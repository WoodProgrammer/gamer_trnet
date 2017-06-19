

from django.db import connections


sample_game_datas = {'mw3':'12','minecraft':'23','doom3':'43'}

def get_amount():
    price_json = {}
    my_json = { " ":" ", "":"", "mw3":"12", "mw2":"15", "minecraft":"122"}

    for price in sample_game_datas:
        try:
            price_json[price] = int(my_json[price]) * int(sample_game_datas[price])
        except:
            pass

    return price_json



print(get_amount())