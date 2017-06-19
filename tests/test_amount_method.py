import json


def json_converter(keys,values):

  main_template =''
  for i in range(len(keys)):
    data_template  = ' "{}":"{}"'.format(keys[i],values[i])
    if (i == len(keys)-1) :
      main_template += data_template
    else:
      main_template += data_template + ","

  return "{"+main_template+"}"





import psycopg2

game_json = {}
connect_str = "dbname='epin_test' user='emirozbir' host='localhost' " + \
              "password=' '"
conn = psycopg2.connect(connect_str)
cursor = conn.cursor()
x = cursor.execute("SELECT name,game_pin_price FROM epinmain_game")
game_datas = cursor.fetchall()


game_names = []
game_prices = []
data = {}
for i in range(3):
    k=0
    try:
       game_names.append(game_datas[i][k])
       game_prices.append(game_datas[i][k+1])
    except:
        pass

game_data_from_db= json_converter(game_names,game_prices)

game_json = json.loads(game_data_from_db)





customer_test_data = { "mw3":"23", "mw2":"68"}

for i in customer_test_data.keys():


        print( "bu oyuna >>> {}".format(i) + " " +  str(float(game_json[i]) * float(customer_test_data[i])))
