import graphene
from django.core.exceptions import PermissionDenied
from graphene_django import DjangoObjectType
from graphene_django.filter import DjangoFilterConnectionField

from phison_realestate_backend.core.models import (
    BuyerPaymentSchedule,
    Property,
    PropertyImage,
)


class PropertyImageNode(DjangoObjectType):
    class Meta:
        model = PropertyImage
        interfaces = (graphene.relay.Node,)
        fields = (
            "image",
            "height",
            "width",
        )


class BuyerPaymentScheduleNode(DjangoObjectType):
    class Meta:
        model = BuyerPaymentSchedule
        fields = (
            "title",
            "description",
            "percentage",
            "amount",
            "deadline",
            "status",
        )
        interfaces = (graphene.relay.Node,)
        filter_fields = ("status",)


class PropertyNode(DjangoObjectType):
    property_image = graphene.String()

    class Meta:
        model = Property
        fields = (
            "name",
            "bed_room_count",
            "bath_room_count",
            "parking_count",
            "description",
            "size",
            "price",
            "is_featured",
            "progress",
            "video",
            "address",
            "location",
            "property_type",
            "images",
        )
        interfaces = (graphene.relay.Node,)
        filter_fields = ("is_featured",)

    def resolve_property_image(root, info):
        return root.property_image


class Query(graphene.ObjectType):
    property = graphene.relay.Node.Field(PropertyNode)
    all_properties = DjangoFilterConnectionField(PropertyNode)

    all_user_payment_schedules = DjangoFilterConnectionField(BuyerPaymentScheduleNode)

    def resolve_all_user_payment_schedules(self, info):
        user = info.context.user
        if not user.is_authenticated:
            raise PermissionDenied("You must be logged in to see schedules.")

        return BuyerPaymentSchedule.objects.filter(buyer__customer=user)
