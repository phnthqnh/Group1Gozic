from django.urls import path

from .controllers.product_controller import ProductListAPIView, ProductDetailAPIView
from .controllers.category_controller import CategoryListAPIView, CategoryDetailAPIView
from . import views

urlpatterns = [
    path('', views.home_view, name='home'),
    path('product/<int:pk>/', views.product_detail_view, name='product_detail'),

    path('api/products/', ProductListAPIView.as_view(), name='api_product_list'),
    path('api/products/<int:pk>/', ProductDetailAPIView.as_view(), name='api_product_detail'),

    path('api/categories/', CategoryListAPIView.as_view(), name='api_category_list'),
    path('api/categories/<int:pk>/', CategoryDetailAPIView.as_view(), name='api_category_detail'),
]

from clothes.views import *
from .controllers.product_controller import ProductListAPIView, ProductDetailAPIView
from .controllers.category_controller import CategoryListAPIView, CategoryDetailAPIView
from . import views
urlpatterns = [

    path('', views.home_view, name='home'),
    path('product/<int:pk>/', views.product_detail_view, name='product_detail'),

    path('api/products/', ProductListAPIView.as_view(), name='api_product_list'),
    path('api/products/<int:pk>/', ProductDetailAPIView.as_view(), name='api_product_detail'),

    path('api/categories/', CategoryListAPIView.as_view(), name='api_category_list'),
    path('api/categories/<int:pk>/', CategoryDetailAPIView.as_view(), name='api_category_detail'),

    path('login/', login_view, name='login'),
    path('account/',account_view,name='account'),
    path('register/phone/', register_phone_view, name='register_phone'),
    path('register/info/', register_info_view, name='register_info'),

    path('api/register/', RegisterAPI.as_view(), name='api_register'),
    path('api/login/', LoginAPI.as_view(), name='api-login')
]

