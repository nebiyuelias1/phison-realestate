from django.urls import path
from django.views.generic import TemplateView

from .views import PropertyCreateView, PropertyListView

app_name = "phison_panel"
urlpatterns = [
    path("", PropertyListView.as_view(), name="home"),
    path(
        "property/new/",
        PropertyCreateView.as_view(),
        name="new_property",
    ),
    path(
        "buyers/",
        TemplateView.as_view(template_name="phison_panel/buyer_list.html"),
        name="buyer_list",
    ),
]
