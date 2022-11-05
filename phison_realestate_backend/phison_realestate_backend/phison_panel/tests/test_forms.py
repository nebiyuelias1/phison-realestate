from phison_realestate_backend.phison_panel.forms import PaymentInformationForm


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
