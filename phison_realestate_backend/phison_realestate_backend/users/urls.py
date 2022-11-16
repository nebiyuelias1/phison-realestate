from django.urls import path

from phison_realestate_backend.users.views import (
    non_staff_member_list_ajax_view,
    user_detail_view,
    user_redirect_view,
    user_update_view,
)

app_name = "users"
urlpatterns = [
    path("~redirect/", view=user_redirect_view, name="redirect"),
    path("~update/", view=user_update_view, name="update"),
    path("<str:username>/", view=user_detail_view, name="detail"),
    path("ajax/customers/", non_staff_member_list_ajax_view, name="ajax_user_list"),
]
