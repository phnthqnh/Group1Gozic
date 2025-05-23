from django.shortcuts import render , get_object_or_404
from .models import *
from .serializers import *
from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login
from django.contrib.auth.decorators import login_required
from .form import LoginForm
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .models import *
from .serializers import *
from .services import auth_service
from drf_yasg.utils import swagger_auto_schema
from rest_framework.permissions import AllowAny
from django.contrib import messages

# Create your views here.


def home_view(request):
    categories = Category.objects.all()
    products = Product.objects.all()
    banners = Banner.objects.all()
    return render(request, 'home.html', {
        'categories': categories,
        'products': products,
        'banners': banners
    })

def product_detail_view(request, pk):
    product = get_object_or_404(Product, pk=pk)
    return render(request, 'product_detail.html', {
        'product': product
    })
    
    
def login_view(request):
    form = LoginForm(request.POST or None)
    if request.method == 'POST' and form.is_valid():
        phone = form.cleaned_data['user_phone']
        password = form.cleaned_data['password']
        user = authenticate(request,phone=phone,password=password)
        if user is not None:
            login(request, user)
            return redirect('home')  
        else:
            form.add_error(None, "Tài khoản hoặc mật khẩu không đúng.")
    return render(request, 'login.html', {'form': form})

@login_required
def account_view(request):
    return render(request, 'accounts.html',{'user':request.user})


def register_phone_view(request):
    if request.method == "POST":
        phone = request.POST.get('phone')
        if not phone:
            return render(request, 'register_phone.html', {'error': 'Vui lòng nhập số điện thoại'})
        
        if User.objects.filter(phone=phone).exists():
            return render(request, 'register_phone.html', {'error': 'Số điện thoại đã tồn tại'})

        request.session['register_phone'] = phone
        return redirect('register_info')
    return render(request, 'register_phone.html')

def register_info_view(request):
    phone = request.session.get('register_phone')
    if request.method == "POST":
        name = request.POST.get('name')
        address = request.POST.get('address')
        password = request.POST.get('password')
        confirm_password = request.POST.get('confirm_password')
        if not all([name, address, password, confirm_password]):
            return render(request, 'register_info.html', {'error': 'Vui lòng nhập đầy đủ thông tin'})

        if password != confirm_password:
            return render(request, 'register_info.html', {'error': 'Mật khẩu không khớp'})

        try:
            auth_service.register_user(phone, name, password, address)
            messages.success(request, 'Đăng ký thành công!')
            return redirect('login')
        except Exception as e:
            messages.error(request, str(e))


        # Đăng nhập ngay sau khi đăng ký
        # login(request, user)

    return render(request, 'register_info.html', {'phone': phone})

class RegisterAPI(APIView):
    permission_classes = [AllowAny]

    @swagger_auto_schema(request_body=RegisterSerializer)
    def post(self, request):
        serializer = RegisterSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({"message": "Đăng ký thành công"}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class LoginAPI(APIView):
    permission_classes = [AllowAny]

    @swagger_auto_schema(request_body=LoginSerializer)
    def post(self, request):
        serializer = LoginSerializer(data=request.data)
        if serializer.is_valid():
            phone = serializer.validated_data['user_phone']
            password = serializer.validated_data['password']
            user = authenticate(request, phone=phone, password=password)
            if user is not None:
               
                return Response({
                    "message": "Đăng nhập thành công",
                    "user": {
                        "id": user.id,
                        "name": user.name,
                        "phone": user.phone
                    }
                }, status=status.HTTP_200_OK)
            return Response({"error": "Tài khoản hoặc mật khẩu không đúng."}, status=status.HTTP_401_UNAUTHORIZED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

