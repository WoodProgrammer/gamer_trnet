from datetime import datetime

from django.shortcuts import render, get_object_or_404, redirect

# Create your views here.
from game.forms import GameForm
from game.models import Game


def IndexView(request):

    all_game = Game.objects.all()
    return render(request, "index.html", {"all_game":all_game})

def AddGame(request):
    if not request.user.is_superuser:
        return redirect("game:index")

    if request.method == "POST":
        form = GameForm(request.POST)

        if form.is_valid():

            game = form.save(commit=False)
            game.save()
            return redirect("game:detail", id=game.id)
    else:
        form = GameForm()
    return render(request, "addgame.html", {"form":form})

def UpdateView(request, id):

    game = get_object_or_404(Game, id=id)
    if request.method == "POST":
        form = GameForm(request.POST, instance=game)
        game.update_date = datetime.now()
        form.save()
        return redirect("game:detail", id=id)
    else:
        form = GameForm()
    return render(request, "update.html", {"form":form})

def DetailView(request, id):
    game = get_object_or_404(Game, id=id)
    return render(request, "detail.html", {"game":game})

def DeleteView(request, id):
    if not request.user.is_superuser:
        return redirect("game:index")
    try:
        get_object_or_404(Game, id=id).delete()
        return redirect("game:index")
    except:
        raise "Error"

