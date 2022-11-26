from decimal import Decimal

from django import forms
from django.core.exceptions import ValidationError
from django.forms import formset_factory
from django.forms.models import BaseInlineFormSet, inlineformset_factory
from django.utils.text import slugify
from django.utils.timezone import now
from django.utils.translation import gettext_lazy as _

from phison_realestate_backend.core.models import (
    Buyer,
    BuyerPaymentSchedule,
    PaymentInformation,
    Property,
    PropertyImage,
)


class PropertyForm(forms.ModelForm):
    class Meta:
        model = Property
        fields = (
            "name",
            "bed_room_count",
            "bath_room_count",
            "parking_count",
            "description",
            "size",
            "price",
            "is_featured",
            "progress",
            "video",
            "address",
            "location",
        )

    def save(self, commit: bool = ...):
        if self.instance.slug is None or self.instance.slug == "":
            name = self.cleaned_data.get("name")
            timestamp = str(now().timestamp())
            slug = f"{name}-{timestamp}"
            self.instance.slug = slugify(slug, allow_unicode=True)

        return super().save(commit)


class PaymentInformationForm(forms.ModelForm):
    class Meta:
        model = PaymentInformation
        fields = (
            "title",
            "time_period",
            "amount",
            "description",
        )


PaymentInformationFormSet = inlineformset_factory(
    Property,
    model=PaymentInformation,
    form=PaymentInformationForm,
    min_num=1,
    validate_min=True,
)


class BuyerForm(forms.ModelForm):
    class Meta:
        model = Buyer
        fields = (
            "property",
            "customer",
        )


class BuyerPaymentScheduleForm(forms.ModelForm):
    class Meta:
        model = BuyerPaymentSchedule
        fields = (
            "title",
            "percentage",
            "deadline",
            "description",
        )

    def save(self, commit: bool):
        self.instance.amount = (
            Decimal(self.instance.percentage) * self.instance.buyer.property.price
        )
        return super().save(commit)


class BaseBuyerPaymentScheduleFormSet(BaseInlineFormSet):
    def clean(self) -> None:
        super().clean()

        percentage_sum = 0
        for form in self.forms:
            percentage_sum += form.instance.percentage

        if percentage_sum != 100:
            raise ValidationError(
                _("Percentage sum does not equal 100."), code="invalid sum"
            )


BuyerPaymentScheduleFormSet = inlineformset_factory(
    Buyer,
    model=BuyerPaymentSchedule,
    form=BuyerPaymentScheduleForm,
    formset=BaseBuyerPaymentScheduleFormSet,
    min_num=1,
    validate_min=True,
)


class PropertyImageForm(forms.ModelForm):
    class Meta:
        model = PropertyImage
        fields = ("image",)


class PropertyImageIdForm(forms.Form):
    image_id = forms.CharField()


PropertyImageIdFormSet = formset_factory(
    PropertyImageIdForm,
    min_num=1,
    validate_min=True,
    max_num=4,
    validate_max=True,
)
