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
