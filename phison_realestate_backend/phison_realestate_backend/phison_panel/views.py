from typing import Any

from django.contrib.messages.views import SuccessMessageMixin
from django.forms import BaseForm
from django.http import HttpResponse
from django.utils.translation import gettext_lazy as _
from django.views.generic.edit import CreateView
from django.views.generic.list import ListView

from phison_realestate_backend.core.models import Property

from .forms import PaymentInformationFormSet, PropertyForm
from .mixins import StaffMemberRequiredMixin


class PropertyListView(StaffMemberRequiredMixin, ListView):
    model = Property
    template_name = "phison_panel/property_list.html"


class PropertyCreateView(StaffMemberRequiredMixin, SuccessMessageMixin, CreateView):
    model = Property
    template_name = "phison_panel/property_form.html"
    form_class = PropertyForm
    success_message = _("Property saved successfully")

    def _get_payment_information_form_set(self):
        if self.request.POST:
            return PaymentInformationFormSet(self.request.POST)
        else:
            return PaymentInformationFormSet()

    def get_context_data(self, **kwargs: Any) -> dict[str, Any]:
        data = super().get_context_data(**kwargs)

        data["formset"] = self._get_payment_information_form_set()

        return data

    def post(self, request, *args: str, **kwargs):
        return super().post(request, *args, **kwargs)

    def form_valid(self, form: BaseForm) -> HttpResponse:
        form_set = self._get_payment_information_form_set()

        if form_set.is_valid():
            self.object = form.save()
            form_set.instance = self.object
            form_set.save()
            return super().form_valid(form)
        else:
            return self.form_invalid(form)
