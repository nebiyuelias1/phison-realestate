from django.contrib.auth import get_user_model
from django.contrib.auth.backends import BaseBackend

from phison_realestate_backend import firebase

AUTH_HEADER_NAME = "HTTP_AUTHORIZATION"


UserModel = get_user_model()


class FirebaseAuthenticationBackend(BaseBackend):
    def authenticate(self, request, **kwargs):
        if not request:
            return None

        token = request.META.get(AUTH_HEADER_NAME)
        if not token:
            return None

        try:
            decoded_token = firebase.verify_token(token)
            uid = decoded_token.get("uid")
            user = UserModel._default_manager.get_by_natural_key(uid)
            return user
        except Exception:
            return None
