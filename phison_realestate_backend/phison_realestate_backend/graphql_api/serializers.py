from rest_framework import serializers


class RegistrationSerializer(serializers.Serializer):
    email = serializers.EmailField(required=True)

    phone = serializers.CharField(required=True)

    name = serializers.CharField(required=True)

    token = serializers.CharField(required=True)
