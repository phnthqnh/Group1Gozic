from django.core.exceptions import ValidationError
from clothes.models import User

def register_user(phone, name, password, address):
    if User.objects.filter(phone=phone).exists():
        raise ValidationError("Số điện thoại đã tồn tại.")

    user = User.objects.create_user(phone=phone, name=name, password=password, address=address)
    return user
