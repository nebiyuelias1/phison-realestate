from django.urls import path
from django.views.generic import TemplateView

from .views import (
    BuyerCreateView,
    PropertyCreateView,
    PropertyListAjaxView,
    PropertyListView,
)

app_name = "phison_panel"

property_urls = [
    path("", PropertyListView.as_view(), name="home"),
    path(
        "properties/new/",
        PropertyCreateView.as_view(),
        name="new_property",
    ),
    path("ajax/properties/", PropertyListAjaxView.as_view(), name="ajax_property_list"),
]

buyer_urls = [
    path(
        "buyers/",
        TemplateView.as_view(template_name="phison_panel/buyer_list.html"),
        name="buyer_list",
    ),
    path(
        "buyers/new/",
        BuyerCreateView.as_view(),
        name="new_buyer",
    ),
]

urlpatterns = property_urls + buyer_urls
