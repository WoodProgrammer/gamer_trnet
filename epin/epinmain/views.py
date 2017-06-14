from django.shortcuts import render,render_to_response
from django.http import HttpResponseRedirect
from django.contrib import auth

import json

def login(request):

    return render_to_response('login.html')