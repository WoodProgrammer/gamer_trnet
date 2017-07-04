from django.conf.urls import url
from . import views
app_name = 'epinmaiin'
urlpatterns = [
    url(r'^login/$', views.index,name= 'login'),
    url(r'^auth/$', views.auth_detection, name='login'),
    url(r'^signup/$', views.signup, name='signup'),
    url(r'^logout/$', views.logout, name='logout'),
    url(r'^createaccounts/$', views.createaccounts, name='logout'),
    url(r'^search/$', views.search, name='search'),

]