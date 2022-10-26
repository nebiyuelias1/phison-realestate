import json

import pytest
from graphene_django.utils.testing import graphql_query

from phison_realestate_backend.graphql_api.serializers import RegistrationSerializer
from phison_realestate_backend.users.models import User

pytestmark = pytest.mark.django_db


@pytest.mark.django_db
class TestMutations:
    @pytest.fixture
    def client_query(self, client):
        def func(*args, **kwargs):
            return graphql_query(*args, **kwargs, client=client)

        return func

    def test_register_mutation(self, client_query, mocker):
        self.name = "Test Name"
        self.email = "test@domain.com"
        self.phone_number = "+251911111111"
        self.token = "testtoken"
        self.username = "testuid"

        user = User.objects.create(
            username=self.username,
            name=self.name,
            phone_number=self.phone_number,
            email=self.email,
        )

        mocker.patch(
            "phison_realestate_backend.graphql_api.serializers.RegistrationSerializer.create",
            return_value=user,
        )
        response_data = {
            "name": self.name,
            "email": self.email,
            "phoneNumber": self.phone_number,
        }
        create_data = {**response_data, "token": self.token}

        response = client_query(
            """
            mutation myMutation($input: AuthMutationInput!) {
                register(input: $input) {
                    name
                    email
                    phoneNumber
                }
            }
            """,
            operation_name="myMutation",
            input_data=create_data,
        )
        content = json.loads(response.content)
        assert "errors" not in content
        assert content["data"]["register"] == response_data
        RegistrationSerializer.create.assert_called_once()
