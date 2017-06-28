from django.conf.urls import url
from . import views
app_name = 'epinmain'
urlpatterns = [
    url(r'^login/$', views.index,name= 'login'),
    url(r'^auth/$', views.auth_detection, name='login'),

]