import pytest

from phison_realestate_backend.phison_panel.forms import (
    BuyerForm,
    BuyerPaymentScheduleForm,
    PaymentInformationForm,
    PropertyForm,
)
from phison_realestate_backend.phison_panel.tests.factories import PropertyFactory
from phison_realestate_backend.users.tests.factories import UserFactory


class TestPropertyForm:
    def setup(self):
        self.required_fields = ["name", "description", "size", "price", "progress"]
        self.data = {
            "name": "Test name",
            "description": "Test Description",
            "size": 42,
            "price": 1000,
            "progress": "Test progress",
        }
        self.Form = PropertyForm
        self.required_error_message = "This field is required."

    def test_invalid_form(self):
        for field in self.required_fields:
            # Remove field from data
            value = self.data.pop(field)
            form = self.Form(self.data)
            assert form.is_valid() is False
            assert form.errors[field][0] == self.required_error_message
            # Put value back to data for subsequent validation.
            self.data[field] = value

    def test_valid_form(self):
        form = self.Form(self.data)
        assert form.is_valid() is True
        assert form.errors == {}


class TestPaymentInformationForm:
    """Test class for PaymentInformationForm."""

    def setup(self):
        self.title = "Test title"
        self.time_period = "Test Period"
        self.amount = 1000
        self.description = "Test description"

        self.Form = PaymentInformationForm
        self.required_error_message = "This field is required."

    def test_missing_title(self):
        data = {
            "time_period": self.time_period,
            "amount": self.amount,
            "description": self.description,
        }

        form = self.Form(data)
        assert form.is_valid() is False
        assert form.errors["title"][0] == self.required_error_message

    def test_missing_time_period(self):
        data = {
            "title": self.title,
            "amount": self.amount,
            "description": self.description,
        }

        form = self.Form(data)
        assert form.is_valid() is False
        assert form.errors["time_period"][0] == self.required_error_message

    def test_missing_amount(self):
        data = {
            "title": self.title,
            "time_period": self.time_period,
            "description": self.description,
        }

        form = self.Form(data)
        assert form.is_valid() is False
        assert form.errors["amount"][0] == self.required_error_message

    def test_missing_description(self):
        data = {
            "title": self.title,
            "time_period": self.time_period,
            "amount": self.amount,
        }

        form = self.Form(data)
        assert form.is_valid() is False
        assert form.errors["description"][0] == self.required_error_message

    def test_valid_form(self):
        data = {
            "title": self.title,
            "time_period": self.time_period,
            "amount": self.amount,
            "description": self.description,
        }

        form = self.Form(data)
        assert form.is_valid() is True
        assert form.errors == {}


@pytest.mark.django_db
class TestBuyerForm:
    def setup(self):
        self.Form = BuyerForm

    def test_valid_form(self):
        property = PropertyFactory.create()
        customer = UserFactory.create()

        data = {
            "property": property.pk,
            "customer": customer.pk,
        }

        form = self.Form(data)
        assert form.is_valid()
        assert form.errors == {}

    def test_invalid_form(self):
        data = {
            "property": 1,
            "customer": 2,
        }

        form = self.Form(data)
        assert form.is_valid() is False
        assert form.errors != {}


class TestBuyerPaymentScheduleForm:
    def setup(self):
        self.data = {
            "title": "test title",
            "percentage": 23.0,
            "deadline": "2023-06-04 15:23:08.367007+00:00",
            "description": "test description",
        }
        self.Form = BuyerPaymentScheduleForm
        self.required_error_message = "This field is required."

    def test_missing_fields(self):
        for key in self.data.keys():
            data = {**self.data}
            del data[key]

            form = BuyerPaymentScheduleForm(data=data)
            assert form.is_valid() is False
            assert form.errors[key][0] == self.required_error_message

    def test_valid_form(self):
        form = self.Form(self.data)
        assert form.is_valid()
        assert form.errors == {}
