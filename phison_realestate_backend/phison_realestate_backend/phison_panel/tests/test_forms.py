from phison_realestate_backend.phison_panel.forms import (
    PaymentInformationForm,
    PropertyForm,
)


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
