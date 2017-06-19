

import psycopg2

connect_str = "dbname='epin_test' user='emirozbir' host='localhost' " + \
              "password=' '"
conn = psycopg2.connect(connect_str)
cursor = conn.cursor()
x = cursor.execute("SELECT id,game_pin_price FROM epinmain_game")
game_datas = cursor.fetchall()
for i in range(3):
    k=0
    try:
        print("{}".format(i) +" "+ str(game_datas[i][k+1]))
    except:
        pass



