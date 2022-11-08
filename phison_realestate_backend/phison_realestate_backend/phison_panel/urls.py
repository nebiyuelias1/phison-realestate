from django.urls import path

from .views import PropertyCreateView, PropertyListView

app_name = "phison_panel"
urlpatterns = [
    path("", PropertyListView.as_view(), name="home"),
    path(
        "property/new/",
        PropertyCreateView.as_view(),
        name="new_property",
    ),
]
