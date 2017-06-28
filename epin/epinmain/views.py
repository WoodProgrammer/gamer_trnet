from django.shortcuts import render, render_to_response
from django.http import HttpResponseRedirect
from django.http import HttpResponse
from django.contrib import auth
from django.template.context_processors import csrf
from .models import Profile, Game
from django.contrib.auth.models import User
from django.contrib.sessions.models import Session
from django.contrib.sessions.backends.db import SessionStore
from django.db import connections
import psycopg2
import logging
import time

logging.basicConfig(filename="test.log", level=logging.DEBUG)

import json

logger = logging.getLogger(__name__)



####AUTHENTICATION METHODS

def index(request):
    if request.user.is_authenticated():
        return render(request,"index.html")
    else:
        return render(request,"login.html")



def auth_detection(request):
    username = request.POST.get('username', '')
    password = request.POST.get('password', '')
    print(username)
    print(password)

    user = auth.authenticate(username=username,password=password)
    print(user)
    if user is not None:
        auth.login(request,user)
        return render(request,"games.html")
    else:
        return render(request, "login.html")




def signup(request):
    c = {}
    c.update(csrf(request))
    return render('signup.html', c)


def createaccounts(request):
    name = request.POST.get('name', '')
    surname = request.POST.get('surname', '')
    username = request.POST.get('username', '')
    email = request.POST.get('email', '')
    password = request.POST.get('password', '')
    birth_date = request.POST.get('birth_date', '')

    user_obj = User.objects.create(username="{}".format(name), email="{}".format(email), password="{}".format(password))





    user_obj.save()
    profile_data = Profile.objects.create(user=user_obj)
    profile_data.birth_date = "2010-12-23"
    return HttpResponseRedirect('/games/games/')


def loggedin(request):
    return render('games.html', {'full_name': request.user.username})





def logout(request):
    auth.logout(request)
    return HttpResponseRedirect('/accounts/login')
