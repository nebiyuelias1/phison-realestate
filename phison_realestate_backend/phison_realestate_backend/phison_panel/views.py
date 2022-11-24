import json
from http import HTTPStatus
from typing import Any

from django.contrib.auth import get_user_model
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
from django.views.generic.edit import CreateView, FormView, UpdateView
from django.views.generic.list import ListView

from phison_realestate_backend.core.models import Buyer, Property, PropertyImage
from phison_realestate_backend.phison_panel.mixins import (
    GetFormSetMixin,
    PropertyTypeOptionsMixin,
    SavePropertyImageMixin,
)

from ..core.mixins import PaginateMixin, StaffMemberRequiredMixin
from .forms import (
    BuyerForm,
    BuyerPaymentScheduleFormSet,
    PropertyForm,
    PropertyImageForm,
    PropertyImageIdFormSet,
)
from .serializers import PropertyModelSerializer

User = get_user_model()


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

    def get_queryset(self) -> models.QuerySet[Property]:
        queryset = super().get_queryset()
        filter_by = self.request.GET.get("filter_by", None)
        if filter_by:
            queryset = queryset.filter(property_type=filter_by)

        q = self.request.GET.get("q", None)
        if q:
            queryset = queryset.filter(name__icontains=q)

        return queryset

    def get_context_data(self, **kwargs: Any):
        data = super().get_context_data(**kwargs)

        q = self.request.GET.get("q", None)
        if q:
            data["q"] = q

        filter_by = self.request.GET.get("filter_by", None)
        if filter_by:
            data["filter_by"] = filter_by

        data["property_count"] = Property.objects.count()
        data["customer_count"] = User.objects.get_non_staff_members().count()
        data["buyer_count"] = Buyer.objects.count()

        return data


class PropertyCreateView(
    StaffMemberRequiredMixin,
    GetFormSetMixin,
    SavePropertyImageMixin,
    PropertyTypeOptionsMixin,
    SuccessMessageMixin,
    CreateView,
):
    model = Property
    template_name = "phison_panel/property_form.html"
    form_class = PropertyForm
    success_message = _("Property saved successfully")

    def get_context_data(self, **kwargs: Any):
        data = super().get_context_data(**kwargs)

        data["formset"] = self.get_payment_information_form_set()
        data["image_formset"] = self.get_property_image_form_set()

        return data

    def form_valid(self, form: BaseForm) -> HttpResponse:
        form_set = self.get_payment_information_form_set()
        property_image_form_set = self.get_property_image_form_set()

        if form_set.is_valid() and property_image_form_set.is_valid():
            self.object = form.save()
            form_set.instance = self.object
            form_set.save()
            property_image_ids = [
                int(property_image["image_id"])
                for property_image in property_image_form_set.cleaned_data
            ]
            self.save_property_images(property_image_ids)
            return super().form_valid(form)
        else:
            return self.form_invalid(form)


class PropertyDetailView(StaffMemberRequiredMixin, DetailView):
    model = Property
    template_name = "phison_panel/property_detail.html"


class PropertyEditView(
    StaffMemberRequiredMixin,
    GetFormSetMixin,
    PropertyTypeOptionsMixin,
    SuccessMessageMixin,
    SavePropertyImageMixin,
    UpdateView,
):
    form_class = PropertyForm
    template_name = "phison_panel/property_form.html"
    success_message = "Property edited successfully"
    model = Property

    def form_valid(self, form: PropertyForm) -> HttpResponse:
        image_formset_data = self._get_image_formset_initial_data()
        image_form_set = self.get_property_image_form_set(initial=image_formset_data)

        payment_formset_data = self._get_payment_info_formset_initial_data()
        payment_info_form_set = self.get_payment_information_form_set(
            initial=payment_formset_data
        )

        if image_form_set.is_valid() and payment_info_form_set.is_valid():
            image_ids_to_be_saved = [
                int(property_image["image_id"])
                for property_image in image_form_set.cleaned_data
            ]
            self.save_property_images(image_ids_to_be_saved)

            image_ids_to_be_deleted = [
                int(form.cleaned_data["image_id"])
                for form in image_form_set.deleted_forms
            ]
            self._delete_property_images(image_ids_to_be_deleted)

            payment_info_form_set.instance = self.object
            payment_info_form_set.save()

            return super().form_valid(form)
        else:
            return self.form_invalid(form)

    def get_context_data(self, **kwargs: Any):
        data = super().get_context_data(**kwargs)

        image_formset_data = self._get_image_formset_initial_data()
        data["image_formset"] = self.get_property_image_form_set(
            initial=image_formset_data
        )

        payment_info_data = self._get_payment_info_formset_initial_data()
        data["formset"] = self.get_payment_information_form_set(payment_info_data)

        return data

    def _get_image_formset_initial_data(self):
        image_ids = list(self.object.images.all().values_list("pk", flat=True))
        image_formset_data = [{"image_id": id} for id in image_ids]
        return image_formset_data

    def _get_payment_info_formset_initial_data(self):
        payment_infos = list(
            self.object.payment_infos.all().values(
                "title", "time_period", "amount", "description"
            )
        )
        return payment_infos

    def _delete_property_images(self, image_ids):
        PropertyImage.objects.filter(id__in=image_ids).delete()


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
            queryset = queryset.filter(property__property_type=filter_by)

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
