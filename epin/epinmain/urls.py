from django.conf.urls import url
from . import views
app_name = 'epinmain'
urlpatterns = [
    url(r'^login/$', views.login,name= 'login'),
    url(r'^auth/$',views.auth_view,name="auth_view"),
    url(r'^loggedin/$',views.loggedin,name="auth_view"),
    url(r'^logout/$', views.logout, name="auth_view"),
    url(r'^signup/$',views.signup,name="signup"),
    url(r'^createaccounts/$',views.createaccounts,name="create_accounts"),
]