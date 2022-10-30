import graphene
from graphene_django import DjangoObjectType
from graphene_django.rest_framework.mutation import SerializerMutation

from phison_realestate_backend.users.models import User

from .serializers import RegistrationSerializer


class UserType(DjangoObjectType):
    class Meta:
        model = User


class AuthMutation(SerializerMutation):
    class Meta:
        serializer_class = RegistrationSerializer

    user = graphene.Field(UserType)


class Mutation(graphene.ObjectType):
    register = AuthMutation.Field()
