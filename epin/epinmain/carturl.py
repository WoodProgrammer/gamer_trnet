from django.conf.urls import url
from . import views
app_name = 'epinmain'
urlpatterns = [
    url(r'^shop/$', views.shop,name= 'login'),
    url(r'^create_carts/$', views.create_cart, name='login'),

]