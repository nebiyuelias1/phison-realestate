import json
from http import HTTPStatus
from typing import Any

from django.contrib.messages.views import SuccessMessageMixin
from django.db import models
from django.db.models import Q
from django.forms import BaseForm
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render
from django.urls import reverse
from django.utils.translation import gettext_lazy as _
from django.views.generic.base import View
from django.views.generic.detail import DetailView
from django.views.generic.edit import CreateView, FormView
from django.views.generic.list import ListView

from phison_realestate_backend.core.models import Buyer, Property, PropertyImage

from ..core.mixins import PaginateMixin, StaffMemberRequiredMixin
from .forms import (
    BuyerForm,
    BuyerPaymentScheduleFormSet,
    PaymentInformationFormSet,
    PropertyForm,
    PropertyImageForm,
    PropertyImageIdFormSet,
)
from .serializers import PropertyModelSerializer


# Property views
# ------------------------------------------------------------
class PropertyListAjaxView(StaffMemberRequiredMixin, View):
    def get(self, request, *args, **kwargs):
        queryset = Property.objects.all()
        query_param = self.request.GET.get("q", "")
        if query_param:
            queryset = queryset.filter(name__icontains=query_param)

        queryset = queryset[:5]
        serializer = PropertyModelSerializer(queryset, many=True)
        json_data = json.dumps(serializer.data)
        return JsonResponse(data=json_data, safe=False)


class PropertyListView(StaffMemberRequiredMixin, PaginateMixin, ListView):
    template_name = "phison_panel/property_list.html"
    model = Property


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

    def _get_property_image_form_set(self):
        if self.request.POST:
            return PropertyImageIdFormSet(self.request.POST)
        else:
            return PropertyImageIdFormSet()

    def _save_property_images(self, form_set):
        property_image_ids = list(
            map(lambda x: int(x["image_id"]), form_set.cleaned_data)
        )
        property_images = PropertyImage.objects.filter(id__in=property_image_ids)
        property_images.update(property=self.object)

    def get_context_data(self, **kwargs: Any):
        data = super().get_context_data(**kwargs)

        data["formset"] = self._get_payment_information_form_set()
        data["image_formset"] = self._get_property_image_form_set()

        return data

    def form_valid(self, form: BaseForm) -> HttpResponse:
        form_set = self._get_payment_information_form_set()
        property_image_form_set = self._get_property_image_form_set()

        if form_set.is_valid() and property_image_form_set.is_valid():
            self.object = form.save()
            form_set.instance = self.object
            form_set.save()
            self._save_property_images(property_image_form_set)
            return super().form_valid(form)
        else:
            return self.form_invalid(form)


class PropertyDetailView(DetailView):
    model = Property
    template_name = "phison_panel/property_detail.html"


class UploadPropertyImageView(StaffMemberRequiredMixin, FormView):
    form_class = PropertyImageForm

    def form_valid(self, form: PropertyImageForm) -> HttpResponse:
        form.save()
        return JsonResponse(data={"id": form.instance.pk}, status=HTTPStatus.CREATED)

    def form_invalid(self, form: PropertyImageForm) -> HttpResponse:
        return JsonResponse(data=form.errors, status=HTTPStatus.BAD_REQUEST)


# end Property views

# Buyer views
# ------------------------------------------------------------


class BuyerListView(StaffMemberRequiredMixin, PaginateMixin, ListView):
    model = Buyer
    template_name = "phison_panel/buyer_list.html"

    def get_queryset(self) -> models.QuerySet[Buyer]:
        queryset = super().get_queryset()
        filter_by = self.request.GET.get("filter_by", None)
        if filter_by:
            # TODO: Filter based on property type
            queryset = queryset

        q = self.request.GET.get("q", None)
        if q:
            queryset = queryset.filter(Q(customer__name=q) | Q(property__name=q))
        return queryset

    def get_context_data(self, **kwargs: Any):
        data = super().get_context_data(**kwargs)

        q = self.request.GET.get("q", None)
        if q:
            data["q"] = q

        filter_by = self.request.GET.get("filter_by", None)
        if filter_by:
            data["filter_by"] = filter_by

        return data


class BuyerCreateView(StaffMemberRequiredMixin, SuccessMessageMixin, CreateView):
    model = Buyer
    template_name = "phison_panel/buyer_form.html"
    form_class = BuyerForm
    success_message = _("Buyer saved successfully")

    def _get_buyer_payment_schedule_form_set(self):
        if self.request.POST:
            return BuyerPaymentScheduleFormSet(self.request.POST)
        else:
            return BuyerPaymentScheduleFormSet()

    def get_context_data(self, **kwargs: Any):
        data = super().get_context_data(**kwargs)

        data["formset"] = self._get_buyer_payment_schedule_form_set()

        return data

    def form_valid(self, form: BaseForm) -> HttpResponse:
        form_set = self._get_buyer_payment_schedule_form_set()

        if form_set.is_valid():
            self.object = form.save()
            form_set.instance = self.object
            form_set.save()
            return super().form_valid(form)
        else:
            return self.form_invalid(form)

    def get_success_url(self) -> str:
        return reverse("phison_panel:buyer_list")


# end Buyer views


def render_partial_template(request, partial):
    """Render a partial template.

    Args:
        request (Request): Django request object.
        partial (str): The name of the partial template.
    """

    return render(request, template_name=f"partials/{partial}")
