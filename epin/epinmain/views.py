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
import json


logging.basicConfig(filename="test.log", level=logging.DEBUG)

import json
##### META DEFINITIONS
logger = logging.getLogger(__name__)
cursor = connections['alias'].cursor()
######


## FOR DEBUGGING PAGES
def login(request):
   return render(request, "login.html")
def home(request):
   return render(request, "index.html")
def register(request):
   return render(request, "register.html")

## FOR DEBUGGING PAGES

####GAMES METHODSa

def fetch_all_game():
    game_show_data = {}
    show_game_name=[]
    show_game_price=[]
    games = cursor.execute("SELECT * FROM epinmain_game")
    data = cursor.fetchall()
    for i in data:
        show_game_name.append(i[1])
        show_game_price.append(i[2])
    return show_game_name,show_game_price


def games(request):
    if request.user.is_authenticated():
        if request.session['language'] == "tr":

            logging.debug("USER {} FETCHED GAMES".format(request.user))
            return render_to_response("tr/oyunlar.html",{"game_data":fetch_all_game()})
        else:
            logging.debug("USER {} FETCHED GAMES".format(request.user))
            return render_to_response("eng/games.html", {"game_data": fetch_all_game()})

    else:
        return render(request, "login.html")





####AUTHENTICATION METHODS

def index(request):
    if request.user.is_authenticated():
        return HttpResponseRedirect('/games/games/')
    else:
        return render(request,"login.html")



def auth_detection(request):

    request.session['language']=request.POST.get('lang')

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
    logging.debug("USER {} CREATED  ".format(request.user))

    return HttpResponseRedirect('/accounts/login/')


def loggedin(request):
    logging.debug("USER {} LOGIN ".format(request.user))

    return render('games.html', {'full_name': request.user.username})


def logout(request):
    auth.logout(request)
    logging.debug("USER {} LOGOUT ".format(request.user))

    return HttpResponseRedirect('/accounts/login/')




##########CART METHODS


def index(request):
    return render(request,"eng/index.html")



def json_serialize():



    pass

def create_cart(request):

    return render(request,"create_cart.html")

def finish_sell(request):
    return render(request,"finish.html")

def show_cart(request):
    game_name = request.POST.get('game_name','')
    game_money_count = request.POST.get('game_money_count','')
    try :
        request.session['game_name'] += game_name
        request.session['game_money_count'] += game_money_count

    except:
        request.session['game_name'] = []
        request.session['game_money_count'] = []

        request.session['game_name'] += game_name
        request.session['game_money_count'] += game_money_count
    cart_data = json_serialize( request.session['game_name'], request.session['game_money_count'])
    return render(request,"cart.html",{'cart_data': cart_data})