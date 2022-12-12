from typing import Any

from phison_realestate_backend.core.models import Property, PropertyImage
from phison_realestate_backend.phison_panel.forms import (
    BuyerPaymentScheduleFormSet,
    PaymentInformationFormSet,
    PropertyImageIdFormSet,
)


class GetFormSetMixin:
    def get_payment_information_form_set(self, initial=None):
        if self.request.POST:
            return PaymentInformationFormSet(
                self.request.POST, instance=self.object, initial=initial
            )
        else:
            return PaymentInformationFormSet(instance=self.object, initial=initial)

    def get_property_image_form_set(self, initial=None):
        if self.request.POST:
            return PropertyImageIdFormSet(self.request.POST, initial=initial)
        else:
            return PropertyImageIdFormSet(initial=initial)

    def get_buyer_payment_schedule_form_set(self, initial=None):
        if self.request.POST:
            return BuyerPaymentScheduleFormSet(
                self.request.POST, instance=self.object, initial=initial
            )
        else:
            return BuyerPaymentScheduleFormSet(instance=self.object, initial=initial)

class SavePropertyImageMixin:
    def save_property_images(self, property_image_ids):
        property_images = PropertyImage.objects.filter(id__in=property_image_ids)
        property_images.update(property=self.object)


class PropertyTypeOptionsMixin:
    def get_context_data(self, **kwargs: Any):
        data = super().get_context_data(**kwargs)

        data["options"] = Property.PROPERTY_TYPES

        return data
