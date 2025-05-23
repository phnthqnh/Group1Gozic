from clothes.models import *
from clothes.serializers import *
from drf_yasg import openapi
from clothes.services import product_service
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from drf_yasg.utils import swagger_auto_schema

# Create your views here.
class ProductListAPIView(APIView):
    @swagger_auto_schema(
        operation_summary="Tìm kiếm sản phẩm theo tên",
        operation_id="List_Product",
        manual_parameters=[
            openapi.Parameter(
                'name', openapi.IN_QUERY, description="Tìm theo tên sản phẩm", type=openapi.TYPE_STRING
            )
        ],
        tags=["Product"]
    )
    def get(self, request):
        name = request.GET.get('name')
        products = Product.objects.all()
        return Response(ProductSerializer(products, many=True).data)
    @swagger_auto_schema(
        request_body=ProductSerializer,
        operation_summary="Thêm sản phẩm",
        operation_id="Thêm sản phẩm",
        tags=["Product"]
    )
    def post(self,request):
        return product_service.post_product(request.data)
       
class ProductDetailAPIView(APIView):
    @swagger_auto_schema(
        operation_summary="Lấy chi tiết sản phẩm theo ID",
        operation_id="ProductDetail",
        tags=["Product"]
    )
    def get(self, request, pk):
        return product_service.get_products_by_id(pk)

    @swagger_auto_schema(
        operation_summary="Cập nhật sản phẩm theo ID",
        operation_id="Update_Product",
        request_body=ProductSerializer,
        tags=["Product"]
    )
    def put(self, request, pk):
        return product_service.put_product(pk ,request.data)
    
    @swagger_auto_schema(
        operation_summary="Xóa sản phẩm theo ID",
        operation_id="Delete_Product",
        tags=["Product"]
    )
    def delete(self, request, pk):
        return product_service.delete_product(pk , request.data)
       


