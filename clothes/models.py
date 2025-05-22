from django.db import models

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