import json
from http import HTTPStatus

import pytest
from django.conf import settings
from django.contrib import messages
from django.contrib.auth.models import AnonymousUser
from django.contrib.messages.middleware import MessageMiddleware
from django.contrib.sessions.middleware import SessionMiddleware
from django.http import HttpRequest, HttpResponseRedirect
from django.test import RequestFactory
from django.urls import reverse

from phison_realestate_backend.users.forms import UserAdminChangeForm
from phison_realestate_backend.users.models import User
from phison_realestate_backend.users.tests.factories import UserFactory
from phison_realestate_backend.users.views import (
    UserRedirectView,
    UserUpdateView,
    user_detail_view,
)

pytestmark = pytest.mark.django_db


class TestUserUpdateView:
    """
    TODO:
        extracting view initialization code as class-scoped fixture
        would be great if only pytest-django supported non-function-scoped
        fixture db access -- this is a work-in-progress for now:
        https://github.com/pytest-dev/pytest-django/pull/258
    """

    def dummy_get_response(self, request: HttpRequest):
        return None

    def test_get_success_url(self, user: User, rf: RequestFactory):
        view = UserUpdateView()
        request = rf.get("/fake-url/")
        request.user = user

        view.request = request

        assert view.get_success_url() == f"/users/{user.username}/"

    def test_get_object(self, user: User, rf: RequestFactory):
        view = UserUpdateView()
        request = rf.get("/fake-url/")
        request.user = user

        view.request = request

        assert view.get_object() == user

    def test_form_valid(self, user: User, rf: RequestFactory):
        view = UserUpdateView()
        request = rf.get("/fake-url/")

        # Add the session/message middleware to the request
        SessionMiddleware(self.dummy_get_response).process_request(request)
        MessageMiddleware(self.dummy_get_response).process_request(request)
        request.user = user

        view.request = request

        # Initialize the form
        form = UserAdminChangeForm()
        form.cleaned_data = {}
        form.instance = user
        view.form_valid(form)

        messages_sent = [m.message for m in messages.get_messages(request)]
        assert messages_sent == ["Information successfully updated"]


class TestUserRedirectView:
    def test_get_redirect_url(self, user: User, rf: RequestFactory):
        view = UserRedirectView()
        request = rf.get("/fake-url")
        request.user = user

        view.request = request

        assert view.get_redirect_url() == f"/users/{user.username}/"


class TestUserDetailView:
    def test_authenticated(self, user: User, rf: RequestFactory):
        request = rf.get("/fake-url/")
        request.user = UserFactory()

        response = user_detail_view(request, username=user.username)

        assert response.status_code == 200

    def test_not_authenticated(self, user: User, rf: RequestFactory):
        request = rf.get("/fake-url/")
        request.user = AnonymousUser()

        response = user_detail_view(request, username=user.username)
        login_url = reverse(settings.LOGIN_URL)

        assert isinstance(response, HttpResponseRedirect)
        assert response.status_code == 302
        assert response.url == f"{login_url}?next=/fake-url/"


class TestNonStaffMemberListAjaxView:
    @pytest.fixture
    def view_url(self):
        return reverse("users:ajax_user_list")

    def test_unauthenticated_user(self, client, view_url):
        response = client.get(view_url)
        # Login redirect
        assert response.status_code == HTTPStatus.FOUND
        login_url = reverse("account_login")
        redirect_url = f"{login_url}?next={view_url}"
        assert response.url == redirect_url

    def test_authenticated_user(self, admin_client, view_url):
        response = admin_client.get(view_url)

        assert response.status_code == HTTPStatus.OK

    def test_get_user_existing_in_db(self, admin_client, view_url):
        users = UserFactory.create_batch(2)
        response = admin_client.get(view_url)
        assert response.status_code == HTTPStatus.OK
        response_data = json.loads(json.loads(response.content))
        assert len(response_data) == 2
        assert response_data[0]["id"] == users[0].pk
        assert response_data[1]["id"] == users[1].pk

    def test_get_user_with_search_key(self, admin_client, view_url):
        users = UserFactory.create_batch(4)

        # Search using name
        response = admin_client.get(view_url + f"?q={users[0].name}")
        response_data = json.loads(json.loads(response.content))
        assert len(response_data) == 1
        assert response_data[0]["id"] == users[0].pk

        # Search using email address
        response = admin_client.get(view_url + f"?q={users[2].email}")
        response_data = json.loads(json.loads(response.content))
        assert len(response_data) == 1
        assert response_data[0]["id"] == users[2].pk

        # Search using phone number
        response = admin_client.get(view_url + f"?q={users[1].phone_number}")
        response_data = json.loads(json.loads(response.content))
        assert len(response_data) == 1
        assert response_data[0]["id"] == users[1].pk


class TestStaffListView:
    @pytest.fixture
    def view_url(self):
        return reverse("phison_panel:staff_list")

    def test_unauthenticated_user(self, client, view_url):
        response = client.get(view_url)
        # Login redirect
        assert response.status_code == HTTPStatus.FOUND
        login_url = reverse("account_login")
        redirect_url = f"{login_url}?next={view_url}"
        assert response.url == redirect_url

    def test_authenticated_user(self, admin_client, view_url):
        response = admin_client.get(view_url)

        assert response.status_code == HTTPStatus.OK

    def test_shows_staff_list(self, admin_client, view_url):
        response = admin_client.get(view_url)

        assert response.context.get("object_list").count() == 1
