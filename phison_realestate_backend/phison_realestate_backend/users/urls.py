from django.urls import path

from phison_realestate_backend.users.views import (
    add_user_view,
    non_staff_member_list_ajax_view,
    toggle_account_deactivation_view,
    user_detail_view,
    user_redirect_view,
    user_update_view,
)

app_name = "users"
urlpatterns = [
    path("add/", view=add_user_view, name="add_user"),
    path("~redirect/", view=user_redirect_view, name="redirect"),
    path("~update/", view=user_update_view, name="update"),
    path("<str:username>/", view=user_detail_view, name="detail"),
    path("ajax/customers/", non_staff_member_list_ajax_view, name="ajax_user_list"),
    path(
        "deactivate/<pk>/",
        toggle_account_deactivation_view,
        name="toggle_account_deactivation",
    ),
]
