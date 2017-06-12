from django.conf.urls import url
from . import views
from django.conf import settings
from django.conf.urls.static import static

app_name="game"

urlpatterns=[
    url(r"^",views.IndexView,name="index")
]
