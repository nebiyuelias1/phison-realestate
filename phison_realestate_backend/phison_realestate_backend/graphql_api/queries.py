import graphene
from graphene_django import DjangoObjectType
from graphene_django.filter import DjangoFilterConnectionField

from phison_realestate_backend.core.models import Property, PropertyImage


class PropertyImageNode(DjangoObjectType):
    class Meta:
        model = PropertyImage
        interfaces = (graphene.relay.Node,)
        fields = (
            "image",
            "height",
            "width",
        )


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
