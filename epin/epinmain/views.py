from django.shortcuts import render,render_to_response
from django.http import HttpResponseRedirect
from django.http import HttpResponse
from django.contrib import auth
from django.template.context_processors import csrf
from .models import Profile,Game
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



def json_converter(keys,values):
  main_template =''
  for i in range(len(keys)):
   try:
        data_template  = ' "{}":"{}"'.format(keys[i],values[i])
        if (i == len(keys)-1) :
          main_template += data_template
        else:
          main_template += data_template + ","
   except:
       pass
  return "{"+main_template+"}"




def shop(request):

    if request.user.is_authenticated():
        c = {}
        c.update(csrf(request))
        logging.debug("USER : {}".format(request.user.username))

        return render(request,'create_cart.html')
    else:
        logging.debug("CANNOT LOGGED  : {}".format(request.user.username))
        return HttpResponseRedirect('/accounts/login/')

def cart_status(request):
    c = {}
    request.session["username"] = request.user.username
    c.update(csrf(request))
    try:
        request.session["game"] += ',' + request.POST.get("game")
        request.session["count"] += ',' + request.POST.get("count")
        logger.info("CART CREATED by {} {}".format(request.user.username,time.ctime()))



    except Exception as e:
        request.session["game"] =' '
        request.session["count"] =' '
        request.session["game"] += ',' + request.POST.get("game")
        request.session["count"] += ',' + request.POST.get("count")
        logger.error('SESSION KEYS CREATED !')

    print(request.session['game'])


    return HttpResponseRedirect('games/games/')





def games(request):

    if request.user.is_authenticated():
        cart = request.session.get('cart', {})
        my_keys = request.session['game']
        my_vals = request.session['count']
        print(str(request.session['count']))
        print(my_vals.split(','))



        return render('index.html',{'cart_datas':json_converter(my_keys.split(','),my_vals.split(','))})
    else:
        return render('joinus.html')


def login(request):
    c = {}
    c.update(csrf(request))
    if request.user.is_authenticated():
        try:
            return render('games.html', c)
            logger.info("USER {} LOGED TO THE SYSTEM ".format(request.user.username))
        except :
            loggers.info("USER {} CANNOT RENDER game.html TO THE SYSTEM ".format(request.user.username))

    else:
        try:
            return render('login.html',c)##look to the source code.
            logger.info("Eroor!")
        except :
            logger.info("USER {} CANNOT have a template TO THE SYSTEM ".format(request.user.username))


def auth_view(request):
    username = request.POST.get('username','')
    password = request.POST.get('password','')
    user = auth.authenticate(username=username,password=password)

    if user is not None:
        auth.login(request,user)
        request.session['login_status'] = True
        return HttpResponseRedirect('/accounts/loggedin/')
    else:
        return HttpResponseRedirect('/accounts/invalid/')##Javascript ile bir hareket cekicez.




cursor = connections['alias'].cursor()

def add_sale_to_the_sale_table(cart_data,user_id):
    connect_str = "dbname='epin_test' user='emirozbir' host='localhost' " + \
                  "password=' '"
    conn = psycopg2.connect(connect_str)
    cursor = conn.cursor()



    game_json = {}

    x = cursor.execute("SELECT name,game_pin_price FROM epinmain_game")
    game_datas = cursor.fetchall()


    game_names = []
    game_prices = []
    data = {}
    for i in range(len(game_datas)):
        k=0
        try:
           game_names.append(game_datas[i][k])
           game_prices.append(game_datas[i][k+1])
        except:
            pass
            logging.error("add_sale_to_sale_table() error exited with code 1  ")

    game_data_from_db = json_converter(game_names, game_prices)
    print(game_data_from_db)

    customer_main_data = json.loads(cart_data)
    game_json = json.loads(game_data_from_db)
    print(customer_main_data)

    for i in customer_main_data.keys():

       # amount = float(game_json[i]) * float(customer_main_data[i])
        print("Hello")
        print(game_json[i])
        print(customer_main_data[i])
        amount = float(game_json[i]) * float(customer_main_data[i])
        print(amount)

        cursor.execute("INSERT INTO epinmain_sale(amount,game_id_id,user_id) values({},{},{})".format(amount,1,user_id))
        conn.commit()




def sale_finish(request):
    my_keys = request.session['game']
    my_vals = request.session['count']
    user_id = request.user.id

    print(my_keys.split(','))
    print(my_vals.split(','))

    temp_keys = my_keys.split(',')
    temp_vals = my_vals.split(',')


    serialized_cart_data = json_converter(temp_keys[1],temp_vals[1])

    main_template = '{"mw3":"123"}'
    add_sale_to_the_sale_table(main_template,user_id)
    return render('finish_sale.html')


####AUTHENTICATION METHODS



def signup(request):
    c = {}
    c.update(csrf(request))
    return render('signup.html',c)





def createaccounts(request):
    name = request.POST.get('name', '')
    surname = request.POST.get('surname', '')
    username = request.POST.get('username','')
    email = request.POST.get('email', '')
    password = request.POST.get('password', '')
    birth_date = request.POST.get('birth_date', '')

    user_obj = User.objects.create(username ="{}".format(name),email="{}".format(email),password="{}".format(password))
    user_obj.save()
    profile_data = Profile.objects.create(user=user_obj)
    profile_data.birth_date="2010-12-23"
    return HttpResponseRedirect('/games/games/')


def loggedin(request):

    return render('loggedin.html',{'full_name':request.user.username})


def logout(request):
    auth.logout(request)
    return HttpResponseRedirect('/accounts/login')
