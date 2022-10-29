from django.urls import path
from django.views.generic import TemplateView

app_name = "phison_panel"
urlpatterns = [
    path("", TemplateView.as_view(template_name="phison_panel/home.html"), name="home"),
]
