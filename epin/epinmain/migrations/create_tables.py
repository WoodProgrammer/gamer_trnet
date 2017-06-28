import psycopg2
connect_str = "dbname='epin_test' user='emirozbir' host='127.0.0.1' " + \
                      "password=' '"
conn=psycopg2.connect(connect_str)
client_query = conn.cursor()

client_query.execute('''
                        create table sale(
                                      id serial not null primary key,
                                      user_id int not null references users(id),
                                      game_id int not null references game(id),
                                      c_date timestamp default current_timestamp,
                                      price real not null CHECK (price > 0)
                          );
''')



conn.commit()