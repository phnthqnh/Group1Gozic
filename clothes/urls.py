from django.urls import path
from clothes.views import *

urlpatterns = [

    path('login/', login_view, name='login'),
    path('account/',account_view,name='account'),
    path('register/phone/', register_phone_view, name='register_phone'),
    path('register/info/', register_info_view, name='register_info'),

    path('api/register/', RegisterAPI.as_view(), name='api_register'),
]

