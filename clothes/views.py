from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login
from django.contrib.auth.decorators import login_required
from .form import LoginForm

def login_view(request):
    form = LoginForm(request.POST or None)
    if request.method == 'POST' and form.is_valid():
        username = form.cleaned_data['username']
        password = form.cleaned_data['password']
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            return redirect('home')  
        else:
            form.add_error(None, "Tài khoản hoặc mật khẩu không đúng.")
    return render(request, 'login.html', {'form': form})

@login_required
def account_view(request):
    return render(request, 'accounts.html',{'user':request.user})

