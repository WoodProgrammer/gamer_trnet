

 # VERİ TABANI MODELLERİ
   Biz veritabanımızda temel olarak tek bir app üzerinden 5 model ile çalışmaktayız.Modellerimiz:
  
    *  Genre #Oyunların türleri için.
    *  Profile #User class'ından çekilmekte (bu konuya değineceğiz).
    *  Game
    *  Sale 
    *  Log #Kullanılmamakta(şimdilik)
    
# ORM KULLANMADAN EMPTY MIGRATIONS MODELİ OLUŞTURMAK
    * Django da native sql kullanacağımız zaman öncelikle boş bir migration oluşturmamız gerekiyor.
 
    * Bunun için de terminalde manage.py ile entegra edelim
              
    * Ardından migrations klasöründe 0001_custom_models.py adından bir dosya oluşturuldu.
       0001_custom_models.py görüntüsü aşağıdaki gibidir.
    
# DJANGO MIGRATION MODELİ

```py
from __future__ import unicode_literals                                                                                                                                                      
from django.db import migrations                                                                                                                                                                  
class Migration(migrations.Migration):
      dependencies = [
        ('custom_models', '0001_initial'),
              ]
       operations = [                                                                                                                    migrations.RunSQL(''' 
                         ## USERS TABLOSU
                         create table users(
                                      id serial not null primary key,
                                      username varchar(15) not null UNIQUE,
                                      password text not null,
                                      email text not null UNIQUE,
                                      c_date timestamp default current_timestamp,full_name varchar(40) , 
                                      status boolean not null default true,balance real not null default 0,
                                      lastlogin timestamp not null default current_timestamp,
                                      admin boolean not null default false
                         );
                         ##GENRE TABLOSU
                         create table genre(
                                      id serial not null primary key,
                                      name varchar(40) not null UNIQUE
                         );
                        ##GAME TABLOSU
                         create table game(
                                      id serial not null primary key,
                                      name varchar(100) notnull UNIQUE,
                                      price real not null CHECK (price > 0),
                                      popularity int not null,
                                      created_date timestamp not null default current_timestamp,
                                      update_date timestamp not null default current_timestamp,
                                      logo varchar(200),
                                      genre_id int not null references genre(id)
                          );
                          ##SALE TABLOSU
                          create table sale(
                                      id serial not null primary key,
                                      user_id int not null references users(id),
                                      game_id int not null references game(id),
                                      c_date timestamp default current_timestamp,
                                      amount real not null CHECK (price > 0)
                          );

    ''')                                                                                
    ]

  ```

## USER SALE GAME İlişkisi
*  User tablosu ile Sale tablosu birbirine one to many şeklinde bağlı.Yani bizim ana bakmamız gereken durum bir user birden fazla Sale oluşturabilir.

 
# Game ve Sale Tabloları Arasındaki İlişkisellik
*  Aynı şekilde bir ilişki daha Game ile Sales arasında burada ise 1'den çoğa ilişki mevcut yani bir user birden fazla oyun alabilir ve aynı zamanda bir oyun birden fazla sipariş Id'sine sahip olabilmesini sağlamaktadır.
    
* Çoktan çoğa bir ilişki gözlenmektedir.
    
    
    
   
    
    