from django.shortcuts import render , get_object_or_404
from .models import *
from .serializers import *

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
    
    
   