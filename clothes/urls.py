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
