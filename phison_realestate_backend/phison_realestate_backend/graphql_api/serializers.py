from typing import Any

from rest_framework import serializers

from phison_realestate_backend import firebase
from phison_realestate_backend.users.models import User


class RegistrationSerializer(serializers.Serializer):
    """Serializer that will be used to register a new user."""

    email = serializers.EmailField(required=True)

    phone = serializers.CharField(required=True)

    name = serializers.CharField(required=True)

    token = serializers.CharField(required=True)

    def create(self, validated_data: Any):
        email = validated_data.get("email")
        phone = validated_data.get("phone")
        name = validated_data.get("name")
        token = validated_data.get("token")

        decoded_token = firebase.verify_token(token)
        user, _ = User.objects.get_or_create(
            username=decoded_token.get("uid"), email=email, phone_number=phone
        )
        # Allow users to update their name.
        user.name = name
        user.save()

        return user
