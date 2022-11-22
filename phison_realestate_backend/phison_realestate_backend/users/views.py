import json
from http import HTTPStatus

from django.contrib.auth import get_user_model
from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.messages.views import SuccessMessageMixin
from django.db.models import Q, QuerySet
from django.http import JsonResponse
from django.urls import reverse
from django.utils.translation import gettext_lazy as _
from django.views.generic import DetailView, RedirectView, UpdateView
from django.views.generic.base import View
from django.views.generic.edit import FormView
from django.views.generic.list import ListView

from phison_realestate_backend.phison_panel.views import PaginateMixin
from phison_realestate_backend.users.api.serializers import UserSerializer
from phison_realestate_backend.users.forms import UserSignupForm

from ..core.mixins import StaffMemberRequiredMixin

User = get_user_model()


class NonStaffMemberListAjaxView(StaffMemberRequiredMixin, View):
    def get(self, request, *args, **kwargs):
        queryset = User.objects.get_non_staff_members()
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


class AddUserView(StaffMemberRequiredMixin, FormView):
    form_class = UserSignupForm
    template_name = "partials/_add_user_errors.html"

    def dispatch(self, request, *args, **kwargs):
        return super().dispatch(request, *args, **kwargs)

    def form_valid(self, form):
        self.user = form.save(self.request)

        return JsonResponse({"pk": self.user.pk}, status=HTTPStatus.CREATED)


add_user_view = AddUserView.as_view()


class StaffListView(StaffMemberRequiredMixin, PaginateMixin, ListView):
    template_name = "phison_panel/staff_list.html"

    def get_queryset(self) -> QuerySet[User]:
        queryset = User.objects.get_staff_members()
        filter_by = self.request.GET.get("filter_by", None)
        if filter_by:
            if filter_by == "is_superuser":
                queryset = queryset.filter(is_superuser=True)
            elif filter_by == "is_staff":
                queryset = queryset.filter(is_staff=True, is_superuser=False)

        q = self.request.GET.get("q", None)
        if q:
            queryset = queryset.search(q)

        return queryset

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        filter_by = self.request.GET.get("filter_by", None)
        if filter_by:
            data["filter_by"] = filter_by

        q = self.request.GET.get("q", None)
        if q:
            data["q"] = q

        return data


staff_list_view = StaffListView.as_view()
