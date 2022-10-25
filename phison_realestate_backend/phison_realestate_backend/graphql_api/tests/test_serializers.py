import pytest

from phison_realestate_backend import firebase
from phison_realestate_backend.graphql_api.serializers import RegistrationSerializer


class TestRegistrationSerializer:
    def setup(self):
        self.Serializer = RegistrationSerializer

    def _assert(self, fields, serializer: RegistrationSerializer):
        for field in fields:
            assert serializer.errors.get(field) == ["This field is required."]

    def test_valid_serializer(self):
        data = {
            "email": "valid@domain.com",
            "phone": "+251911111111",
            "name": "testname",
            "token": "testtoken",
        }
        serializer = self.Serializer(data=data)
        assert serializer.is_valid() is True
        assert serializer.data == data
        assert serializer.errors == {}

    def test_invalid_serializer(self):
        data = {"email": "valid@domain.com"}
        serializer = self.Serializer(data=data)
        assert serializer.is_valid() is False
        fields = ["phone", "name", "token"]
        self._assert(fields, serializer)

        fields.pop()
        data = {**data, "token": "testtoken"}
        serializer = self.Serializer(data=data)
        assert serializer.is_valid() is False
        self._assert(fields, serializer)

        fields.pop()
        data = {**data, "name": "testname"}
        serializer = self.Serializer(data=data)
        assert serializer.is_valid() is False
        self._assert(fields, serializer)

        fields.pop()
        data = {**data, "phone": "251911111111"}
        serializer = self.Serializer(data=data)
        assert serializer.is_valid() is True
        assert serializer.errors == {}

    def test_validity_of_email(self):
        data = {"phone": "+251911111111", "name": "testname", "token": "testtoken"}
        serializer = self.Serializer(data={"email": "thisisinvalid", **data})
        assert serializer.is_valid() is False
        assert serializer.errors is not None

        serializer = self.Serializer(data={"email": "invalid@domain", **data})
        assert serializer.is_valid() is False
        assert serializer.errors is not None

        serializer = self.Serializer(data={"email": "valid@domain.com", **data})
        assert serializer.is_valid() is True
        assert serializer.errors == {}

    def test_create_calls_verify_token(self, mocker):
        mocker.patch("phison_realestate_backend.firebase.verify_token")
        data = {
            "email": "valid@domain.com",
            "phone": "+251911111111",
            "name": "testname",
            "token": "testtoken",
        }
        serializer = self.Serializer(data=data)
        serializer.is_valid()
        serializer.save()
        firebase.verify_token.assert_called_once_with("testtoken")

    @pytest.mark.django_db
    def test_create_a_user(self, mocker):
        mocker.patch(
            "phison_realestate_backend.firebase.verify_token",
            return_value={"uid": "testuid"},
        )
        data = {
            "email": "valid@domain.com",
            "phone": "+251911111111",
            "name": "testname",
            "token": "testtoken",
        }
        serializer = self.Serializer(data=data)
        serializer.is_valid()
        user = serializer.save()
        assert user.name == "testname"
        assert user.email == "valid@domain.com"
        assert user.username == "testuid"
        assert user.phone_number == "+251911111111"
