from django import forms

from phison_realestate_backend.core.models import PaymentInformation, Property


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
