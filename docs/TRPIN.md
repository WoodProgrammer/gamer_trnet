# TRPIN
Türkiye'de online oyun topluluklarını hedefleyen bir e-pin satış servisi.
## Bağımlılıklar
  * django 1.10.5
  * postgresql 9.5
  * Python 3.6
Öncelikle bizler geliştirme ortamı olarak PyCharm IDE'sini ve UNIX tabanlı bir işletim sistemi tercih ediyoruz.
Versiyonlamak ve projeye destek olmak için

* Linux , MacOS ve Windows(gitshell) :
    ```sh
    $ git clone https://github.com/WoodProgrammer/gamer_trnet.git 
    ```
    
# VERİ TABANI (PostgreSQL 9.5)
* Kendi yerel geliştirme ortamımızda veri tabanı olarak PostgreSql ile etkileşimi sağlamak için:
    ```sh
    $ cd gamer_trnet/epin/epin
    ```
 * epin klasörü içerisinde bulunan yine epin klasörü içerisinde settings.py adı verilen bir Django geliştirme ortamımız için bize config görevi gören bir dosya.Burada 
 ```python 
 
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': VERİ_TABANI_ADI ,
        'USER': KULLANICI_ADI,
        'PASSWORD': PAROLA,
        'HOST': VERI_TABANI_SUNUCUSUNUN_BULUNDUGU_IP,
        'PORT': PORT_NUMARASI,
    }
}
 ```
* Port numarası varsayılan olarak 5432 olarak belirtilmiştir.Ancak portta IN_ADDR_USE tarzı bir exception almamak için varsayılan sistemde 5432 portunun kullanıp kullanılmadığını anlamak için terminale kopyalayıp yapıştırın.

 ```python 
  $ cat /etc/services | grep 5432 | awk '{print $2}'
 ```
* Eğer kullanım altında ise kapatın yoksa port numaranızı değiştirin.

* Port kontrollerini yapıp database için config ayarlarını hallettikten sonra migration işlemlerine yani tabloların veri tabanına ORM ile aktarımı kısmına gelelim.
Öncelikle bulunduğumuz dizini kontrol edelim.
```sh 
  $ pwd
  $ /gamer_trnet/epin ##manage.py bu klasörün altında.
 ```
Şimdi manage.py ile migration işlemlerimizi halledelim.
```sh 
  $ python3 manage.py makemigrations  
  $ python3 manage.py migrate 
```
 Bir hata olmaması durumunda modellerinizi,ve config dosyalarınızı kontrol ediniz.
```sh
 $ psql 
 emirozbir=# \l
                                            List of databases
            Name            |   Owner   | Encoding |   Collate   |    Ctype    |    Access privileges    
----------------------------+-----------+----------+-------------+-------------+-------------------------
 casino_locator             | developer | UTF8     | tr_TR.UTF-8 | tr_TR.UTF-8 | 
 datanut_development        | developer | UTF8     | tr_TR.UTF-8 | tr_TR.UTF-8 | 
 datanut_development2       | developer | UTF8     | tr_TR.UTF-8 | tr_TR.UTF-8 | 
 developer                  | developer | UTF8     | tr_TR.UTF-8 | tr_TR.UTF-8 | 
 game_trnetdb               | developer | UTF8     | tr_TR.UTF-8 | tr_TR.UTF-8 | =Tc/developer   
```
Postgre'de game_trnetdb'nin oluştuğunu görmekteyiz.Daha iyi bir sağlama yapabilmek için tablolarımızın durumuna bakalım 
```sh
game_trnetdb=# \connect game_trnetdb
You are now connected to database "game_trnetdb" as user "emirozbir".
game_trnetdb=# \d
                         List of relations
 Schema |               Name                |   Type   |   Owner   
--------+-----------------------------------+----------+-----------
 public | auth_group                        | table    | developer
 public | auth_group_id_seq                 | sequence | developer
 public | auth_group_permissions            | table    | developer
 public | auth_group_permissions_id_seq     | sequence | developer
 public | auth_permission                   | table    | developer
 public | auth_permission_id_seq            | sequence | developer
 public | users_sale                        | table    | developer
 public | users_sale_id_seq                 | sequence | developer
 public | users_userprofile                 | table    | developer
 public | users_userprofile_id_seq          | sequence | developer
 
 ```
 ## NOT:
 Burada veritabanında tablolarımızın oluşturulduğunu görmekteyiz.Artık veritabanımız hazır hiçbir sorun olmadan yolumuza devam edebiliriz.Olası bir kolon ekleme çıkarmada ise  [models.py](https://github.com/WoodProgrammer/gamer_trnet/blob/master/epin/epinmain/models.py) dosyamızda class'lara yeni instance'lar eklemiş olursak veya varolanları çıkartmış olursak bunların ORM tarafı bir yana veri tabanının iç kısmında bir karşılığının olması gereklidir.Yoksa application server ayağa kalkmaz.
Yani her instance değişiminde.
 
 
 ```sh
     $ python3 manage.py makemigrations  
     $ python3 manage.py migrate 
 ```
 