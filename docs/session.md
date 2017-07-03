# SESSION VERISI ve CART MANTIĞI

* SESSION yapısı ana mantık olarak şu şekilde çalışır.User login olur ve user'ın logout olana kadar ya da servisin işleyişine göre
işlemin bitme anında , belki bir TRANSACTION COMMIT'inde,belki de logout sırasına kadar yaptığı işlemleri istediğiniz şekilde 
serialize edebildiğiniz bir mantık üzerine tutmaktadır.
* SESSION işlemlerini gerçekleştirmek için Django frameworkünde arka planda sizin için birçok method çalışmakta hatta migrations'ta
sizin için otomatik olarak session oluşturmakta ve bunu sizin isteğinize bağlı tutmakta.Yani Session django da da bir model gibi db'de yeri vardır.

# Django Session Yapısı 

* Postgresql'de görüldüğü üzere django bize hazır migration sayesinde bir session tablosu oluşturmuş.
* Burada görülen session_id cookie içerisinde gömülmüş vaziyette bulunmaktadır.Aynı zamanda Session tablomuz veriyi
kript edilmiş halde tutmaktadır.
```sh 
CREATE TABLE "django_session" (
    "session_key" varchar(40) NOT NULL PRIMARY KEY,
    "session_data" text NOT NULL,
    "expire_date" datetime NOT NULL
);
```

* Pyton levelinde Session verisi ile oynamanız gerekirse verileri aşağıdaki şekilde 
pull edip decrypt edebilirsiniz

```py
from django.contrib.sessions.models import Session
   
    sess = Session.objects.get(pk='session_key')
    print(sess.session_data)
    print(sess.get_decoded())
```
Bu methodlar djangoda Session olayları nasıl dönmektedir.Ona dair genel birkaç bilgi içermektedir.
Bu nedenle ilerleyen sayfalarda daha fazla anlatılmayacak ve projede nasıl kullanıldığına odaklanılacaktır.
Daha fazla bilgi için : [DjangoSessionİçinTıklayınız]('http://eli.thegreenplace.net/2011/06/29/django-sessions-part-ii-how-sessions-work')

# CART MANTIĞI

* CART yapısında session kullanımı bir e-ticaret sitesindeki en büyük yardımcılarından bir tanesi.
Eğer session ile cart kullanmasaydık.Her bir cart isteğini veritabanına yazdırsaydık ve onları Sales
tablosunda yazdırıp sonra CART table da silmeler yapsaydık bu ciddi bir performans kaybına neden olurdu.

# [views.py](https://github.com/WoodProgrammer/gamer_trnet/blob/master/epin/epinmain/views.py)

* Burada /cart/shop/ sayfasından gelen requestler parse edilmektedir.
* Ardından 'game' ve 'count' adında iki adet session objesi meydana gelmektedir.

```py
def cart_status(request):
....
..
.
    try:
        request.session["game"] += ',' + request.POST.get("game")
        request.session["count"] += ',' + request.POST.get("count")

```
* Ama django da session oluştururken var olmayan tipi tanımlanmamış bir key kullanımında sorun çıkartmakta.
  Biz de bu sorunu try except kullanarak çözdük.

* İlk başta POST isteğini parse ediyor.
  Ardından session'lara ekleme yapmaya çalışıyor yapamassa except bloğunda tanımlayıp işlemi bitiriyor.

```py
except Exception as e:
        request.session["game"] =' '
        request.session["count"] =' '
        request.session["game"] += ',' + request.POST.get("game")
        request.session["count"] += ',' + request.POST.get("count")
        
   # print(request.session['game'])
    return HttpResponseRedirect('games/games/')
```
Burada session datasını alıp yerine yapıştırdık ancak serialize etmekte problemler yaşıyoruz.
Burada ise 

[views.py](https://github.com/WoodProgrammer/gamer_trnet/blob/master/epin/epinmain/views.py)'daki json_converter kullanımı devreye girmekte.

# Kullanımı:
Json converterda iki parametre geçiyoruz.
* keys ise request.session['game']'i tutmakta
* values ise request.session['game']'i tutmakta
Her bir keys ile values'i match edip sonuç olarak bir json bize generate etmektedir.

# Test Case 
```py
def json_converter(keys,values):
        //codes

keys = 'test_1,test_2,test3'
values = 'val1, al2,val3'

json_converter(keys,values)
```
Çıktısı :

```json
        { "test_1":"val1", "test_2":" al2", "test3":"val3"}
```
Şimdi bu çıktığı normal python3 parse edebiliyor mu bakalım.

```py
import json
json_file = open('test.json','r+')
j = json.loads(json_file.read())
print(j['test_1'])
```
* Yukarıdaki kod parçacığı çalışınca herhangi exception vermeden şöyle bir sonuç çıkmaktadır : ' val1 '.
Testleri geçen bu kod parçacığını sessiondaki cart verisi serialize edeceğimiz noktada kullanacağız.
```py
def games(request):
    //codes
        
        return render_to_response('index.html',{'cart_datas':json_converter(my_keys.split(','),my_vals.split(','))})
```
Sessiondaki cart verisi json ile serialize edilmektedir burada ve test için bu değer return edilmektedir.

```py
return render_to_response('index.html',{'cart_datas':json_converter(my_keys.split(','),my_vals.split(','))}) 
```

