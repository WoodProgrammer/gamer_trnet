from __future__ import unicode_literals

from django.db import models

# Create your models here.
class Game(models.Model):
    name = models.CharField(max_length = 50, unique=True)
    game_price = models.FloatField(default = 0)
    genre  = models.CharField(max_length=15)
    created_date = models.DateTimeField(auto_now_add = True)
    photo  = models.ImageField()
    def __unicode__(self):
        return "GAME CREATED :: >>>>>> {}".format(self.name)

