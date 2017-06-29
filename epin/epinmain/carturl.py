from django.conf.urls import url
from . import views
app_name = 'epinmain'
urlpatterns = [
    url(r'^buy/$', views.create_cart, name='games'),

]