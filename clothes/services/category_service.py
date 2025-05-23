from clothes.models import Product , Category
from clothes.serializers import *
from rest_framework.response import Response
from rest_framework import status

def get_categorys_by_name(name):
    categories = Category.objects.all()
    if name:
        categories = categories.filter(name__icontains=name)
    return categories

def post_category(data):
    serializer = CategorySerializer(data=data)
    if serializer.is_valid():
        serializer.save()
        return Response({"message": "Thành công"}, status=status.HTTP_201_CREATED)
    else:
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
def get_category_by_id(pk):
    try:
        categories =  Category.objects.get(pk=pk)
    except Category.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)
    return Response(CategorySerializer(categories).data)

def put_category(pk,data):
    try:
        categories = Category.objects.get(pk=pk)
    except Category.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)    
    serializer = CategorySerializer(categories, data=data)
    if serializer.is_valid():
        serializer.save()
        return Response({"message": "Cập nhật thành công"})
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

def delete_category(pk ):
    try:
        categories = Category.objects.get(pk=pk)
        categories.delete()
        return Response({"message": "Xóa thành công"}, status=status.HTTP_200_OK)
    except Category.DoesNotExist:
        return Response({"message": "Không tìm thấy sản phẩm"}, status=status.HTTP_404_NOT_FOUND)
    