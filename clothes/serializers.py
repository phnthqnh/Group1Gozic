from rest_framework import serializers
from django.contrib.auth import authenticate
from .models import *
from clothes.models import Product, Category

class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = [ 'id','name']

class ProductSerializer(serializers.ModelSerializer):
    category_name = serializers.SerializerMethodField()
    class Meta:
        model = Product
        fields = '__all__'
        
    def get_category_name(self, obj):
        return obj.category.name if obj.category else None      


class RegisterSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only = True )
    confirm_password = serializers.CharField(write_only = True)
    class Meta:
        model = User
        fields = ['phone', 'name', 'address', 'password', 'confirm_password']
        extra_kwargs = {
            'password': {'write_only': True},
            'confirm_password': {'write_only': True},
        }
    
    def validate(self, data):
        if not data['phone']:
            raise serializers.ValidationError("Số điện thoại không được để trống.")
        if not data['address']:
            raise serializers.ValidationError("Địa chỉ không được để trống.")
        if not data['name']:
            raise serializers.ValidationError("Tên không được để trống.")
        if data['password'] != data['confirm_password']:
            raise serializers.ValidationError("Mật khẩu xác nhận không khớp.")
        
        if User.objects.filter(phone=data['phone']).exists():
            raise serializers.ValidationError("Số điện thoại đã tồn tại.")
        return data

    def create(self, validated_data):
        password = validated_data.pop('password')
        validated_data.pop('confirm_password')
        user = User(**validated_data)
        user.set_password(password)  # Hash mật khẩu
        user.save()
        return user

class LoginSerializer(serializers.Serializer):
    user_phone = serializers.CharField()
    password = serializers.CharField()

    def validate(self, data):
        phone = data.get('user_phone')
        password = data.get('password')

        if not phone:
            raise serializers.ValidationError("Số điện thoại không được để trống.")
        if not password:
            raise serializers.ValidationError("Mật khẩu không được để trống.")

        user = authenticate(request=self.context.get('request'), phone=phone, password=password)
        if user is None:
            raise serializers.ValidationError("Số điện thoại hoặc mật khẩu không đúng.")
        
        data['user'] = user
        return data

    def create(self, validated_data):
        return validated_data['user']

