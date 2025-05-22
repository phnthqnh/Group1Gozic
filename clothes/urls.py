from django.urls import path
from clothes.views import *

urlpatterns = [
    # Web form
    path('register/phone/', register_phone_view, name='register_phone'),
    path('register/info/', register_info_view, name='register_info'),

    # API mobile
    path('api/register/', RegisterAPI.as_view(), name='api_register'),

]
