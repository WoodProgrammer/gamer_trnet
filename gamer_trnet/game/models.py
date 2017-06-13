from __future__ import unicode_literals

from django.db import models

# Create your models here.

class Game(models.Model):

    name = models.CharField(max_length=50, unique=True)
    game_price =models.FloatField(default=0)
    genre = models.ForeignKey("Genre")
    created_date = models.DateTimeField(auto_now_add=True)
    photo = models.ImageField(blank=True)
    update_date = models.DateTimeField(auto_now_add=True)
    def __unicode__(self):
        return self.name

    class Meta:
        ordering = ["-update_date"]

class Genre(models.Model):
    name = models.CharField(max_length=15)
    count = models.IntegerField(default=0)

