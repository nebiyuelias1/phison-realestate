from django.urls import path

from phison_realestate_backend.users.views import staff_list_view

from .views import (
    BuyerCreateView,
    BuyerDetailView,
    BuyerEditView,
    BuyerListView,
    PropertyCreateView,
    PropertyDetailView,
    PropertyEditView,
    PropertyListAjaxView,
    PropertyListView,
    UpdateBuyerPaymentScheduleView,
    UploadPropertyImageView,
    render_partial_template,
)

app_name = "phison_panel"

property_urls = [
    path("", PropertyListView.as_view(), name="home"),
    path(
        "property/new/",
        PropertyCreateView.as_view(),
        name="new_property",
    ),
    path(
        "property/detail/<slug:slug>/",
        PropertyDetailView.as_view(),
        name="property_detail",
    ),
    path(
        "property/edit/<slug:slug>/",
        PropertyEditView.as_view(),
        name="property_edit",
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
        "buyer/",
        BuyerListView.as_view(),
        name="buyer_list",
    ),
    path(
        "buyer/new/",
        BuyerCreateView.as_view(),
        name="new_buyer",
    ),
    path(
        "buyer/edit/<slug:slug>/",
        BuyerEditView.as_view(),
        name="buyer_edit",
    ),
    path(
        "buyer/detail/<slug:slug>/",
        BuyerDetailView.as_view(),
        name="buyer_detail",
    ),
]

payment_schedule_urls = [
    path(
        "payment_schedule/update/<pk>/",
        UpdateBuyerPaymentScheduleView.as_view(),
        name="update_payment_schedule",
    )
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

urlpatterns = (
    property_urls
    + buyer_urls
    + render_partial_urls
    + staff_urls
    + payment_schedule_urls
)
