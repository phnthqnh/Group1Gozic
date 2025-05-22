from clothes.models import *
from clothes.serializers import *
from drf_yasg import openapi
from clothes.services import category_service
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from drf_yasg.utils import swagger_auto_schema

# Create your views here.
class CategoryListAPIView(APIView):
    @swagger_auto_schema(
        operation_summary="Tìm kiếm danh mục theo tên",
        operation_id="List_Product",
        manual_parameters=[
            openapi.Parameter(
                'name', openapi.IN_QUERY, description="Tìm theo tên danh mục", type=openapi.TYPE_STRING
            )
        ],
        tags=["Category"]
    )
    def get(self, request):
        name = request.GET.get('name')
        categories = Category.objects.all()
        return Response(CategorySerializer(categories, many=True).data)
    @swagger_auto_schema(
        request_body=CategorySerializer,
        operation_summary="Thêm danh mục",
        operation_id="Thêm danh mục",
        tags=["Category"]
    )
    def post(self,request):
        return category_service.post_category(request.data)
       
class CategoryDetailAPIView(APIView):
    @swagger_auto_schema(
        operation_summary="Lấy chi tiết danh mục theo ID",
        operation_id="CategoryDetail",
        tags=["Category"]
    )
    def get(self,request, pk):
        return category_service.get_category_by_id(pk)

    @swagger_auto_schema(
        operation_summary="Cập nhật danh mục theo ID",
        operation_id="Update_Category",
        request_body=CategorySerializer,
        tags=["Category"]
    )
    def put(self, request, pk):
        return category_service.put_category(pk , request.data)
    
    @swagger_auto_schema(
        operation_summary="Xóa danh mục theo ID",
        operation_id="Delete_Category",
        tags=["Category"]
    )
    def delete(self, request, pk):
        return category_service.delete_category(pk)
       


