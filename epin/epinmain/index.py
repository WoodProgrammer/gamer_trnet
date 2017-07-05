from django.conf.urls import url
from . import views
app_name = 'epinmain'
urlpatterns = [

    url(r'^$', views.home, name='index'),
    url(r'^login', views.login, name='login'),
    url(r'^register', views.register, name='register'),

]