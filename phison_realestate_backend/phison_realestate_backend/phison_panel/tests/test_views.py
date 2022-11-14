import json
from http import HTTPStatus

import pytest
from django.urls import reverse

from phison_realestate_backend.core.models import PaymentInformation, Property

from .factories import PropertyFactory, PropertyImageFactory

pytestmark = pytest.mark.django_db


class TestPropertyCreateView:
    @pytest.fixture
    def view_url(self):
        return reverse("phison_panel:new_property")

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

    def test_create_property_without_payment_infos(self, admin_client, view_url):
        response = admin_client.post(
            view_url,
            data={
                "name": "test view",
                "bed_room_count": 1,
                "bath_room_count": 2,
                "parking_count": 2,
                "size": 44.47,
                "description": "test description",
                "price": 22.37,
                "progress": "test progress",
            },
        )

        assert Property.objects.count() == 0
        assert PaymentInformation.objects.count() == 0
        assert len(response.context["formset"].non_form_errors()) == 1
        assert response.status_code == HTTPStatus.OK

    def test_create_property_with_payment_infos(self, admin_client, view_url):
        response = admin_client.post(
            view_url,
            data={
                "name": "test view",
                "bed_room_count": 1,
                "bath_room_count": 2,
                "parking_count": 2,
                "size": 44.47,
                "description": "test description",
                "price": 22.37,
                "progress": "test progress",
                "payment_infos-TOTAL_FORMS": 2,
                "payment_infos-MIN_NUM_FORMS": 1,
                "payment_infos-INITIAL_FORMS": 0,
                "payment_infos-0-title": "Test Title 1",
                "payment_infos-0-time_period": "Test period 1",
                "payment_infos-0-amount": 12.35,
                "payment_infos-0-description": "Test description 1",
                "payment_infos-1-title": "Test Title 2",
                "payment_infos-1-time_period": "Test period 2",
                "payment_infos-1-amount": 12.35,
                "payment_infos-1-description": "Test description 2",
            },
        )

        assert Property.objects.count() == 1
        assert PaymentInformation.objects.count() == 2
        assert response.status_code == HTTPStatus.FOUND


class TestPropertyListView:
    @pytest.fixture
    def view_url(self):
        return reverse("phison_panel:home")

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


class TestPropertyListAjaxView:
    @pytest.fixture
    def view_url(self):
        return reverse("phison_panel:ajax_property_list")

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

    def test_get_properties_existing_in_db(self, admin_client, view_url):
        properties = PropertyFactory.create_batch(size=2)
        property_image = PropertyImageFactory.create(property=properties[0])

        response = admin_client.get(view_url)
        assert response.status_code == HTTPStatus.OK
        response_data = json.loads(json.loads(response.content))
        assert len(response_data) == 2
        assert response_data[0]["id"] == properties[1].pk
        assert response_data[1]["id"] == properties[0].pk
        assert len(response_data[1]["images"]) > 0
        assert response_data[1]["images"][0]["id"] == property_image.pk

    def test_get_properties_with_search_key(self, admin_client, view_url):
        properties = PropertyFactory.create_batch(size=2)

        response = admin_client.get(view_url + f"?q={properties[0].name}")

        response_data = json.loads(json.loads(response.content))
        assert len(response_data) == 1
