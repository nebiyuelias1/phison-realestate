import graphene
from graphene_django import DjangoObjectType
from graphene_django.filter import DjangoFilterConnectionField

from phison_realestate_backend.core.models import (
    BuyerPaymentSchedule,
    Notification,
    Property,
    PropertyImage,
)

from .decorators import login_required


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


class NotificationNode(DjangoObjectType):
    class Meta:
        model = Notification
        fields = (
            "is_read",
            "notification_type",
            "data",
            "created_at",
            "updated_at",
        )
        interfaces = (graphene.relay.Node,)
        filter_fields = ("is_read",)


class Query(graphene.ObjectType):
    property = graphene.relay.Node.Field(PropertyNode)
    all_properties = DjangoFilterConnectionField(PropertyNode)

    all_user_payment_schedules = DjangoFilterConnectionField(BuyerPaymentScheduleNode)

    all_user_notifications = DjangoFilterConnectionField(NotificationNode)

    @login_required
    def resolve_all_user_payment_schedules(self, info):
        user = info.context.user
        return BuyerPaymentSchedule.objects.filter(buyer__customer=user)

    @login_required
    def resolve_all_user_notifications(self, info):
        user = info.context.user
        return Notification.objects.filter(user=user)
