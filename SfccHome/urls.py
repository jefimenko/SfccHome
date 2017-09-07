from django.conf.urls import include, url
from django.contrib import admin

import views

urlpatterns = [
    url(r'^admin/', admin.site.urls),

    url(r'^', include('Landing.urls')),
]
