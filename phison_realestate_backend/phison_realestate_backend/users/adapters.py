from typing import Any

from allauth.account.adapter import DefaultAccountAdapter
from allauth.socialaccount.adapter import DefaultSocialAccountAdapter
from django.conf import settings
from django.http import HttpRequest


class AccountAdapter(DefaultAccountAdapter):
    def is_open_for_signup(self, request: HttpRequest):
        return getattr(settings, "ACCOUNT_ALLOW_REGISTRATION", True)

    def save_user(self, request, user, form, commit=True):
        user = super().save_user(request, user, form, False)
        data = form.cleaned_data
        user.name = data["name"]
        user.phone_number = data["phone_number"]
        user.is_superuser = data["is_superuser"]
        user.is_staff = True
        user.save()

        return user

    def pre_login(
        self,
        request,
        user,
        *,
        email_verification,
        signal_kwargs,
        email,
        signup,
        redirect_url
    ):
        super().pre_login(
            request,
            user,
            email_verification=email_verification,
            signup=signup,
            redirect_url=redirect_url,
            signal_kwargs=signal_kwargs,
            email=email,
        )
        if not user.is_staff and not user.is_superuser:
            return self.respond_user_inactive(request, user)


class SocialAccountAdapter(DefaultSocialAccountAdapter):
    def is_open_for_signup(self, request: HttpRequest, sociallogin: Any):
        return getattr(settings, "ACCOUNT_ALLOW_REGISTRATION", True)
