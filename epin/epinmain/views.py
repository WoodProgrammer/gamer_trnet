from django.shortcuts import render,render_to_response
from django.http import HttpResponseRedirect
from django.contrib import auth
from django.template.context_processors import csrf

import json

def login(request):
    c = {}
    c.update(csrf(request))
    return render_to_response('login.html',c)##look to the source code.

def auth_view(request):
    username = request.POST.get('username','')
    password = request.POST.get('password','')
    user = auth.authenticate(username=username,password=password)
    if user is not None:
        auth.login(request,user)
        return HttpResponseRedirect('/accounts/loggedin')
    else:
        return HttpResponseRedirect('/accounts/invalid')##Javascript ile bir hareket cekicez.
def loggedin(request):
    return render_to_response('loggedin.html',{'full_name':request.user.username})