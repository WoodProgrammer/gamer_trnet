from django.shortcuts import render

# Create your views here.
from game.models import Game


def IndexView(request):

    all_game = Game.objects.all()
    return render(request, "index.html", {"all_game":all_game})