import json

from django.contrib.auth import get_user_model
from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.messages.views import SuccessMessageMixin
from django.db.models import Q
from django.http import JsonResponse
from django.urls import reverse
from django.utils.translation import gettext_lazy as _
from django.views.generic import DetailView, RedirectView, UpdateView
from django.views.generic.base import View

from phison_realestate_backend.users.api.serializers import UserSerializer

from ..core.mixins import StaffMemberRequiredMixin

User = get_user_model()


class NonStaffMemberListAjaxView(StaffMemberRequiredMixin, View):
    def get(self, request, *args, **kwargs):
        queryset = User.objects.filter(is_superuser=False, is_staff=False).all()
        query_param = self.request.GET.get("q", "")
        if query_param:
            queryset = queryset.filter(
                Q(name__icontains=query_param)
                | Q(email__icontains=query_param)
                | Q(phone_number__icontains=query_param)
            )

        serializer = UserSerializer(queryset, many=True, context={"request": request})
        json_data = json.dumps(serializer.data)
        return JsonResponse(data=json_data, safe=False)


non_staff_member_list_ajax_view = NonStaffMemberListAjaxView.as_view()


class UserDetailView(LoginRequiredMixin, DetailView):

    model = User
    slug_field = "username"
    slug_url_kwarg = "username"


user_detail_view = UserDetailView.as_view()


class UserUpdateView(LoginRequiredMixin, SuccessMessageMixin, UpdateView):

    model = User
    fields = ["name"]
    success_message = _("Information successfully updated")

    def get_success_url(self):
        assert (
            self.request.user.is_authenticated
        )  # for mypy to know that the user is authenticated
        return self.request.user.get_absolute_url()

    def get_object(self):
        return self.request.user


user_update_view = UserUpdateView.as_view()


class UserRedirectView(LoginRequiredMixin, RedirectView):

    permanent = False

    def get_redirect_url(self):
        return reverse("users:detail", kwargs={"username": self.request.user.username})


user_redirect_view = UserRedirectView.as_view()
