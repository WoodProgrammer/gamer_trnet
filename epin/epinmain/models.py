from django.db import models
from django.contrib.auth.models import User


class Genre(models.Model):
    name = models.CharField(max_length= 225, unique = True)

    def __str__(self):
        return self.name

    class Meta:
        ordering = ["name"]


class Profile(models.Model):
    user = models.OneToOneField(User)
    birth_date = models.DateField(null=True, blank=True)
    status = models.BooleanField(default = True)
    def __str__(self):
        return self.user.username

    class Meta:
        ordering = ["user"]


class Game(models.Model):
    name = models.CharField(max_length=225)
    game_pin_price = models.FloatField(default = 0)
    created_at = models.DateTimeField(auto_now_add=True)
    update_at = models.DateTimeField(auto_now_add=True)
    popularity = models.IntegerField(default = 1)
    game_logo = models.CharField(max_length=250)
    genre = models.ForeignKey(Genre)

    def __str__(self):
        return self.name

    class Meta:
        ordering = ["-update_at"]


class Sale(models.Model):
    game_id = models.ForeignKey(Game, on_delete = models.CASCADE)
    user = models.ForeignKey(Profile)
    amount = models.FloatField(default = 0)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.id

class Log(models.Model):
    log_raise = models.CharField(max_length= 225)
    created_at = models.DateTimeField(auto_now_add=True)
    ip_addr = models.CharField(max_length=225)

    def __str__(self):
        return self.log_raise

    class Meta:
        ordering = ["-created_at"]

