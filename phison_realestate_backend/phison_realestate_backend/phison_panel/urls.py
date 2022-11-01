from django.urls import path
from django.views.generic import TemplateView

app_name = "phison_panel"
urlpatterns = [
    path("", TemplateView.as_view(template_name="phison_panel/home.html"), name="home"),
    path(
        "property/new/",
        TemplateView.as_view(template_name="phison_panel/add_property.html"),
        name="new_property",
    ),
]
