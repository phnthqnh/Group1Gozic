from django.urls import path
from clothes.views import *

urlpatterns = [
    path('login/', login_view, name='login'),
    path('account/',account_view,name='account')
]