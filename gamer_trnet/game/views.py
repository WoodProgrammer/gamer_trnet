from django.shortcuts import render
from game.models import Game
def IndexView(request):
    all_game  = Game.objects.all()
    return render(request,"index.html",{"all_game":all_game})