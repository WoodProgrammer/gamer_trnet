from django.conf.urls import url
from . import views
app_name = 'epinmain'
urlpatterns = [
    url(r'^login/$', views.login,name= 'login'),
    url(r'^logout/$', views.logout, name="auth_view"),
    url(r'^signup/$', views.signup, name="signup"),
]