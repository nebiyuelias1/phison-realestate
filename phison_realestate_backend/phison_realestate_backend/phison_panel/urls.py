from django.urls import path
from django.views.generic import TemplateView

from .views import (
    BuyerCreateView,
    BuyerListView,
    PropertyCreateView,
    PropertyListAjaxView,
    PropertyListView,
    render_partial_template,
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
        BuyerListView.as_view(),
        name="buyer_list",
    ),
    path(
        "buyers/new/",
        BuyerCreateView.as_view(),
        name="new_buyer",
    ),
]

staff_urls = [
    path(
        "staff/",
        TemplateView.as_view(template_name="phison_panel/staff_list.html"),
        name="staff_list",
    ),
]

render_partial_urls = [
    path(
        "render_partial/<partial>/",
        render_partial_template,
        name="render_partial_template",
    ),
]

urlpatterns = property_urls + buyer_urls + render_partial_urls + staff_urls
