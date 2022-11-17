from django import forms
from django.forms.models import inlineformset_factory

from phison_realestate_backend.core.models import Buyer, PaymentInformation, Property


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
        )


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
