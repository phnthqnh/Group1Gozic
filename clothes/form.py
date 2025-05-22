from django import forms

class LoginForm(forms.Form):
    username = forms.CharField(
        label='Nhập số điện thoại hoặc email',
        widget=forms.TextInput(attrs={
            'placeholder': 'Nhập số điện thoại hoặc email',
            'class': 'input-field'
        })
    )
    password = forms.CharField(
        label='Nhập mật khẩu',
        widget=forms.PasswordInput(attrs={
            'placeholder': 'Nhập mật khẩu',
            'class': 'input-field'
        })
    )
