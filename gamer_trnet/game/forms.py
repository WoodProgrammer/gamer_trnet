from django import forms

from game.models import Game


class GameForm(forms.ModelForm):

    class Meta:
        model = Game
        fields = ["name", "game_price", "genre", "photo"]