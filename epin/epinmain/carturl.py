from django.conf.urls import url
from . import views
app_name = 'epinmain'
urlpatterns = [
    url(r'^shop/$', views.shop,name= 'login'),
    url(r'^cart_status/$', views.cart_status, name='login'),
    url(r'^sale/$',views.sale_finish,name="sale")
]