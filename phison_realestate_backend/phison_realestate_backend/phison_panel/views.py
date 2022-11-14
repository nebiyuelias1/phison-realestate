import json
from typing import Any

from django.contrib.messages.views import SuccessMessageMixin
from django.forms import BaseForm
from django.http import HttpResponse, JsonResponse
from django.utils.translation import gettext_lazy as _
from django.views.generic.base import View
from django.views.generic.edit import CreateView
from django.views.generic.list import ListView

from phison_realestate_backend.core.models import Property

from .forms import PaymentInformationFormSet, PropertyForm
from .mixins import StaffMemberRequiredMixin
from .serializers import PropertyModelSerializer


# Property views
# ------------------------------------------------------------
class PropertyListAjaxView(StaffMemberRequiredMixin, View):
    def get(self, request, *args, **kwargs):
        queryset = Property.objects.all()
        serializer = PropertyModelSerializer(queryset, many=True)
        json_data = json.dumps(serializer.data)
        return JsonResponse(data=json_data, safe=False)


class PropertyListView(StaffMemberRequiredMixin, ListView):
    model = Property
    template_name = "phison_panel/property_list.html"
    paginate_by = 10

    def get_context_data(self, **kwargs: Any):
        data = super().get_context_data(**kwargs)
        page = data["page_obj"]
        data["prefix"] = range(1, min(4, page.number))
        data["suffix"] = range(
            max(page.number + 1, page.paginator.num_pages - 4),
            page.paginator.num_pages + 1,
        )
        return data


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

    def get_context_data(self, **kwargs: Any):
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


# end Property views

# Buyer views
# ------------------------------------------------------------
class BuyerCreateView(StaffMemberRequiredMixin, SuccessMessageMixin, CreateView):
    # TODO: Change the model and fields properties once the Buyer model is created.
    model = Property
    fields = ("name",)
    template_name = "phison_panel/buyer_form.html"

    def get_context_data(self, **kwargs: Any):
        data = super().get_context_data(**kwargs)
        modal_type = self.request.GET.get("open_modal", "")

        if modal_type == "property":
            data["show_property_modal"] = True
            data["show_modal"] = True
        elif modal_type == "customer":
            data["show_customer_modal"] = True
            data["show_modal"] = True

        return data


# end Buyer views
