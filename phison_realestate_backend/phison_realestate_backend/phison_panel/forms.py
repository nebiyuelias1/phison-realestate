from django import forms

from ..core.models import PaymentInformation


class PaymentInformationForm(forms.ModelForm):
    class Meta:
        model = PaymentInformation
        fields = (
            "title",
            "time_period",
            "amount",
            "description",
        )
