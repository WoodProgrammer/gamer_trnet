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
##### META DEFINITIONS
logger = logging.getLogger(__name__)
cursor = connections['alias'].cursor()
######





####GAMES METHODS

def games(request):
    if request.user.is_authenticated():
        return render(request, "games.html")
    else:
        return render(request, "login.html")





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
        return HttpResponseRedirect("/games/games/")
    else:

        return HttpResponseRedirect("/accounts/login/")


def signup(request):
    c = {}
    c.update(csrf(request))
    return render(request,'signup.html', c)





def createaccounts(request):
    name = request.POST.get('name', '')
    surname = request.POST.get('surname', '')
    username = request.POST.get('username', '')
    email = request.POST.get('email', '')
    password = request.POST.get('password', '')
    birth_date = request.POST.get('birth_date', '')



    user_obj = User.objects.create(username="{}".format(username), email="{}".format(email), password="{}".format(password))

    x = user_obj.set_password("{}".format(password))

    print
    user_obj.save()

    profile_data = Profile.objects.create(user=user_obj)
    profile_data.birth_date = "{}".format("2010-09-09")
    profile_data.save()
    return HttpResponseRedirect('/accounts/login/')


def loggedin(request):
    return render('games.html', {'full_name': request.user.username})


def logout(request):
    auth.logout(request)
    return HttpResponseRedirect('/accounts/login/')









##########CART METHODS


def create_cart():

    pass


def finish_sell():
    pass