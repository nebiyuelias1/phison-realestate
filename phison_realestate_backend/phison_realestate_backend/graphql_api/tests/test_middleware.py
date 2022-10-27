from unittest import mock

import pytest
from django.contrib import auth
from django.contrib.auth.models import AnonymousUser
from django.test import RequestFactory

from phison_realestate_backend.graphql_api.middleware import (
    FirebaseAuthorizationMiddleware,
)
from phison_realestate_backend.users.tests.factories import UserFactory


@pytest.mark.django_db
class TestAuthenticationMiddleware:
    def setup(self):
        self.middleware = FirebaseAuthorizationMiddleware()
        self.next_mock = mock.Mock()
        self.request_factory = RequestFactory()
        self.user = UserFactory()

    def info(self, **headers):
        request = self.request_factory.post("/", **headers)
        request.user = AnonymousUser()

        return mock.Mock(
            context=request,
            path=["graphql"],
        )

    def test_calls_authenticate(self, mocker):
        mocker.patch("django.contrib.auth.authenticate", return_value=self.user)
        info_mock = self.info()

        self.middleware.resolve(self.next_mock, None, info_mock)

        auth.authenticate.assert_called_once_with(request=info_mock.context)
        self.next_mock.assert_called_once_with(None, info_mock)
        assert info_mock.context.user == self.user

    def test_not_authenticate(self, mocker):
        mocker.patch("django.contrib.auth.authenticate", return_value=None)
        info_mock = self.info()

        self.middleware.resolve(self.next_mock, None, info_mock)
        assert info_mock.context.user == AnonymousUser()
