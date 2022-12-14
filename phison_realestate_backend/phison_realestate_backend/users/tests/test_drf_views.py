from django.test import RequestFactory

from phison_realestate_backend.users.api.views import UserViewSet
from phison_realestate_backend.users.models import User


class TestUserViewSet:
    def test_get_queryset(self, user: User, rf: RequestFactory):
        view = UserViewSet()
        request = rf.get("/fake-url/")
        request.user = user

        view.request = request

        assert user in view.get_queryset()

    def test_me(self, user: User, rf: RequestFactory):
        view = UserViewSet()
        request = rf.get("/fake-url/")
        request.user = user

        view.request = request

        response = view.me(request)

        assert response.data == {
            "id": user.pk,
            "username": user.username,
            "name": user.name,
            "url": f"http://testserver/api/users/{user.username}/",
            "email": user.email,
            "phone_number": user.phone_number,
        }
