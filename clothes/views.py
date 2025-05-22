from django.shortcuts import render, redirect
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .models import *
from .serializers import *
from .services import auth_service
from drf_yasg.utils import swagger_auto_schema
from rest_framework.permissions import AllowAny
from django.contrib import messages


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