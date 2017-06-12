from __future__ import unicode_literals

from django.db import models

# Create your models here.
from game.models import Game


class UserProfile(models.Model):

    user = models.OneToOneField("auth.User")
    status = models.BooleanField(default=True)

class Sale(models.Model):

    user = models.ForeignKey("auth.User")
    game = models.ForeignKey(Game)
    balance = models.FloatField()
    create_date = models.DateTimeField(auto_now_add=True)