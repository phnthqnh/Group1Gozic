from clothes.models import Product
from clothes.serializers import *
from rest_framework.response import Response
from rest_framework import status

def get_product_by_name(name):
    products = Product.objects.all()
    if name:
        products = products.filter(name__icontains=name)
    return products

def post_product(data):
    serializer = ProductSerializer(data=data)
    if serializer.is_valid():
        serializer.save()
        return Response({"message": "Thành công"}, status=status.HTTP_201_CREATED)
    else:
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
def get_products_by_id(pk):
    try:
        product =  Product.objects.get(pk=pk)
    except Product.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)
    return Response(ProductSerializer(product).data)

def put_product(pk,data):
    try:
        product = Product.objects.get(pk=pk)
    except Product.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)    
    serializer = ProductSerializer(product, data=data)
    if serializer.is_valid():
        serializer.save()
        return Response({"message": "Cập nhật thành công"})
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

def delete_product(pk , data):
    try:
        product = Product.objects.get(pk=pk)
        product.delete()
        return Response({"message": "Xóa thành công"}, status=status.HTTP_200_OK)
    except Product.DoesNotExist:
        return Response({"message": "Không tìm thấy sản phẩm"}, status=status.HTTP_404_NOT_FOUND)