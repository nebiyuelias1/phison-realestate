import graphene
from django.conf import settings
from django.core.cache import cache
from graphene_django import DjangoObjectType
from graphene_django.filter import DjangoFilterConnectionField

from phison_realestate_backend.core.models import (
    Buyer,
    BuyerPaymentSchedule,
    Notification,
    PaymentInformation,
    Property,
    PropertyImage,
)
from phison_realestate_backend.users.models import User

from .decorators import login_required
from .utils import get_usd_to_etb_exchange_rate


class PropertyImageNode(DjangoObjectType):
    image = graphene.String()

    class Meta:
        model = PropertyImage
        interfaces = (graphene.relay.Node,)
        fields = (
            "image",
            "height",
            "width",
        )

    def resolve_image(root, info):
        if root.image:
            request = info.context
            return request.build_absolute_uri(f"{settings.MEDIA_URL}{root.image}")


class BuyerNode(DjangoObjectType):
    class Meta:
        model = Buyer
        fields = ("property",)
        interfaces = (graphene.relay.Node,)


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
            "buyer",
        )
        interfaces = (graphene.relay.Node,)
        filter_fields = ("status",)


class PaymentInformationNode(DjangoObjectType):
    class Meta:
        model = PaymentInformation
        fields = ("title", "time_period", "amount", "description")
        interfaces = (graphene.relay.Node,)


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
            "payment_infos",
        )
        interfaces = (graphene.relay.Node,)
        filter_fields = ("is_featured",)

    def resolve_property_image(root, info):
        if root.property_image:
            request = info.context
            return request.build_absolute_uri(
                f"{settings.MEDIA_URL}/{root.property_image}"
            )


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


class UserType(DjangoObjectType):
    class Meta:
        model = User
        fields = (
            "name",
            "phone_number",
            "email",
        )


class Query(graphene.ObjectType):
    property = graphene.relay.Node.Field(PropertyNode)
    all_properties = DjangoFilterConnectionField(PropertyNode)

    all_user_payment_schedules = DjangoFilterConnectionField(BuyerPaymentScheduleNode)

    all_user_notifications = DjangoFilterConnectionField(NotificationNode)

    me = graphene.Field(UserType)

    usd_to_etb_rate = graphene.Float()

    @login_required
    def resolve_all_user_payment_schedules(self, info):
        user = info.context.user
        return BuyerPaymentSchedule.objects.filter(buyer__customer=user)

    @login_required
    def resolve_all_user_notifications(self, info):
        user = info.context.user
        return Notification.objects.filter(user=user)

    @login_required
    def resolve_me(root, info):
        user = info.context.user
        return user

    def resolve_usd_to_etb_rate(root, info):
        key_name = "usd_to_etb_key"

        rate = cache.get(key_name)

        if rate:
            return rate

        rate = get_usd_to_etb_exchange_rate()

        # Cache for a day
        cache_ttl = 24 * 60 * 60
        cache.set(key_name, rate, cache_ttl)

        return rate
