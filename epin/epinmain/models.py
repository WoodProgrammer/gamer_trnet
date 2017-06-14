from django.db import models
from django.contrib.auth.models import User
class Genre(models.Model):
    name = models.CharField(max_length= 225)

class Profile(models.Model):
    user = models.OneToOneField(User,)
    birth_date = models.DateField(null=True, blank=True)
    status = models.BooleanField(default = True)


class Game(models.Model):
    name = models.CharField(max_length=225)
    game_pin_price = models.FloatField(default = 0)
    created_at = models.DateField()
    popularity = models.IntegerField(default = 1)
    game_logo = models.CharField(max_length=250)
    genre = models.ForeignKey(Genre)
    def __unicode__(self):
        return self.name

class Sale(models.Model):
    game_id = models.ForeignKey(Game,on_delete = models.CASCADE)
    user = models.ForeignKey(Profile)
    amount = models.FloatField(default = 0)
    created_at = models.DateTimeField()


class Log(models.Model):
    log_raise = models.CharField(max_length= 225)
    created_at = models.DateTimeField()
    ip_addr = models.CharField(max_length= 225)

