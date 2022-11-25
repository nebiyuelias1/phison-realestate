from django.urls import path

from phison_realestate_backend.users.views import staff_list_view

from .views import (
    BuyerCreateView,
    BuyerListView,
    PropertyCreateView,
    PropertyDetailView,
    PropertyListAjaxView,
    PropertyListView,
    UploadPropertyImageView,
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
    path(
        "property/detail/<slug:slug>/",
        PropertyDetailView.as_view(),
        name="property_detail",
    ),
    path("ajax/properties/", PropertyListAjaxView.as_view(), name="ajax_property_list"),
    path(
        "ajax/upload-property-image/",
        UploadPropertyImageView.as_view(),
        name="upload_image",
    ),
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
        staff_list_view,
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
