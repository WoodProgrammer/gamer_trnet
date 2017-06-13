from django.contrib.auth import authenticate, login
from django.shortcuts import render, redirect


# Create your views here.


def login_view(request):
    if request.user.is_authenticated():
        return redirect('game:index')
    template_name="login.html"
    if request.method == "POST":
        username = request.POST['username']
        password = request.POST['password']
        user = authenticate(username=username, password=password)
        if user is not None:
            if user.is_active:
                login(request, user)
                return redirect('game:index')
            else:
                return render(request, template_name, {'error_message': 'Your account has been disabled'})
        else:
            return render(request,template_name, {'error_message': 'Invalid login'})
    return render(request, template_name)

