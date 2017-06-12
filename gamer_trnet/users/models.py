from __future__ import unicode_literals
from django.db import models

from game.models import Game

class UserProfile(models.Model):
    user = models.OneToOneField("auth.User")
    status = models.BooleanField(default= True)

class Sale(models.Model):
    user = models.ForeignKey("auth.User")
    game = models.ForeignKey(Game)
    balance = models.FloatField(default = 0)
    date = models.DateTimeField(auto_now_add = True)