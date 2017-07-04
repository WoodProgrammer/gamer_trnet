from django.conf.urls import url
from . import views
app_name = 'epinmain'
urlpatterns = [
    url(r'^buy/$', views.create_cart, name='games'),
    url(r'^showcart/$', views.show_cart, name='games'),
    url(r'^finish/$', views.finish_sell, name='games'),

]