import pytest

from phison_realestate_backend.core.models import Property
from phison_realestate_backend.phison_panel.forms import (
    BuyerForm,
    BuyerPaymentScheduleForm,
    BuyerPaymentScheduleFormSet,
    PaymentInformationForm,
    PropertyForm,
    PropertyImageForm,
    PropertyImageIdFormSet,
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
            "property_type": Property.APARTMENT,
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

    @pytest.mark.django_db
    def test_slugify(self):
        form = self.Form(self.data)
        form.is_valid()
        form.save()
        property = Property.objects.first()
        assert property is not None
        assert property.slug is not None
        assert property.slug != ""


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


class TestBuyerPaymentScheduleFormSet:
    def setup(self):
        self.Form = BuyerPaymentScheduleFormSet

    def test_invalid_form_set(self):
        data = {
            "schedules-TOTAL_FORMS": 2,
            "schedules-MIN_NUM_FORMS": 1,
            "schedules-INITIAL_FORMS": 0,
            "schedules-0-title": "test title",
            "schedules-0-percentage": 23.0,
            "schedules-0-deadline": "2023-06-04 15:23:08.367007+00:00",
            "schedules-0-description": "test description",
            "schedules-1-title": "test title",
            "schedules-1-percentage": 23.0,
            "schedules-1-deadline": "2023-06-04 15:23:08.367007+00:00",
            "schedules-1-description": "test description",
        }

        form = self.Form(data)
        assert form.is_valid() is False
        assert form.non_form_errors()[0] == "Percentage sum does not equal 100."

    def test_valid_form_set(self):
        data = {
            "schedules-TOTAL_FORMS": 2,
            "schedules-MIN_NUM_FORMS": 1,
            "schedules-INITIAL_FORMS": 0,
            "schedules-0-title": "test title",
            "schedules-0-percentage": 23.0,
            "schedules-0-deadline": "2023-06-04 15:23:08.367007+00:00",
            "schedules-0-description": "test description",
            "schedules-1-title": "test title",
            "schedules-1-percentage": 77.0,
            "schedules-1-deadline": "2023-06-04 15:23:08.367007+00:00",
            "schedules-1-description": "test description",
        }

        form = self.Form(data)
        assert form.is_valid()


class TestPropertyImageForm:
    def setup(self):
        self.Form = PropertyImageForm

    def test_valid_form(self, temp_image):
        form = self.Form(None, {"image": temp_image})
        form.is_valid()


class TestPropertyImageIdFormSet:
    def setup(self):
        self.FormSet = PropertyImageIdFormSet

    def test_max_nums(self):
        data = {
            "form-TOTAL_FORMS": "5",
            "form-INITIAL_FORMS": "0",
            "form-MIN_FORMS": "1",
        }

        form_set = self.FormSet(data)
        assert form_set.is_valid() is False
        assert form_set.non_form_errors() == ["Please submit at most 4 forms."]

    def test_zero_forms(self):
        data = {
            "form-TOTAL_FORMS": "0",
            "form-INITIAL_FORMS": "0",
            "form-MIN_FORMS": "1",
        }

        form_set = self.FormSet(data)
        assert form_set.is_valid() is False
        assert form_set.non_form_errors() == ["Please submit at least 1 form."]

    def test_invalid_form(self):
        data = {
            "form-TOTAL_FORMS": "1",
            "form-INITIAL_FORMS": "0",
            "form-MIN_FORMS": "1",
            "form-0-image_id": "",
        }

        form_set = self.FormSet(data)
        assert form_set.is_valid() is False
        assert form_set.errors == [{"image_id": ["This field is required."]}]

    def test_valid_form(self):
        data = {
            "form-TOTAL_FORMS": "1",
            "form-INITIAL_FORMS": "0",
            "form-MIN_FORMS": "1",
            "form-0-image_id": "1",
        }
        form_set = self.FormSet(data)
        assert form_set.is_valid()
