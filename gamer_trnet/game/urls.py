from django.conf.urls import url
from . import views
from django.conf import settings
from django.conf.urls.static import static

app_name="game"

urlpatterns=[
    url(r"^$", views.IndexView, name="index"),
    url(r"^add/$", views.AddGame, name="create"),
    url(r'^(?P<id>[0-9]+)/delete/$', views.DeleteView, name="delete"),
    url(r'^(?P<id>[0-9]+)/$', views.DetailView, name="detail"),
    url(r'^(?P<id>[0-9]+)/update/$', views.UpdateView, name="update"),

]