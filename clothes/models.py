from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager

# Create your models here.

class Category(models.Model):
    name = models.CharField(max_length=255)
    
    def __str__(self):
        return self.name
class Product(models.Model):
    name = models.CharField(max_length=255)
    category = models.ForeignKey(Category , on_delete=models.CASCADE)
    price  = models.DecimalField(max_digits=10 , decimal_places=2)
    description = models.CharField(max_length=255,default="Chất liệu đẹp")
    image = models.ImageField(upload_to='products/',null=True , blank=True)
  
    def __str__(self):
        return self.name
    
    @classmethod
    def get_by_category(cls , category_id):
        return cls.objects.filter(category_id = category_id)
        
class Banner(models.Model):
    image = models.ImageField(null=True , blank=True)
    link = models.URLField(blank=True)
    def __str__(self):
        return f"Banner {self.id}"

class UserManager(BaseUserManager):
    def create_user(self, phone, address, password=None, **extra_fields):
        if not phone:
            raise ValueError("Số điện thoại là bắt buộc")
        user = self.model(phone=phone, address=address, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

class User(AbstractBaseUser):
    phone = models.CharField(max_length=15, unique=True)
    name = models.CharField(max_length=100, blank=True)
    address = models.CharField(max_length=255, blank=True)
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)
    objects = UserManager()

    USERNAME_FIELD = 'phone'
    REQUIRED_FIELDS = []

    def __str__(self):
        return self.phone

