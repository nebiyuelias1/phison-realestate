import pytest
from django.test import RequestFactory

from phison_realestate_backend import firebase
from phison_realestate_backend.graphql_api.backends import (
    AUTH_HEADER_NAME,
    FirebaseAuthenticationBackend,
)
from phison_realestate_backend.users.tests.factories import UserFactory


@pytest.mark.django_db
class TestFirebaseAuthenticationBackend:
    def setup(self):
        self.request_factory = RequestFactory()
        self.backend = FirebaseAuthenticationBackend()
        self.token = "testtoken"
        self.user_id = "testuid"
        self.user = UserFactory(username=self.user_id)

    def test_authenticate_calls_verify_token(self, mocker):
        headers = {AUTH_HEADER_NAME: self.token}
        mocker.patch(
            "phison_realestate_backend.firebase.verify_token",
            return_value={"uid": self.user_id},
        )
        request = self.request_factory.post("/graphql", **headers)

        self.backend.authenticate(request)
        firebase.verify_token.assert_called_once_with(self.token)

    def test_authenticate_user(self, mocker):
        headers = {AUTH_HEADER_NAME: self.token}
        mocker.patch(
            "phison_realestate_backend.firebase.verify_token",
            return_value={"uid": self.user_id},
        )
        request = self.request_factory.post("/graphql", **headers)
        user = self.backend.authenticate(request)
        assert user == self.user

    def test_authenticate_throws_exception(self, mocker):
        headers = {AUTH_HEADER_NAME: self.token}
        mocker.patch(
            "phison_realestate_backend.firebase.verify_token", side_effect=Exception()
        )
        request = self.request_factory.post("/graphql", **headers)
        user = self.backend.authenticate(request)
        assert user is None

    def test_authenticate_null_request(self):
        user = self.backend.authenticate(None)
        assert user is None

    def test_authenticate_missing_auth_header(self):
        request = self.request_factory.post("/graphql")
        user = self.backend.authenticate(request)
        assert user is None
