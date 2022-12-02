from rest_framework.serializers import CharField, ModelSerializer

from phison_realestate_backend.core.models import Property


class PropertyModelSerializer(ModelSerializer):
    property_image = CharField()
    property_type = CharField(source="get_property_type_display")

    class Meta:
        model = Property
        fields = [
            "id",
            "name",
            "bed_room_count",
            "bath_room_count",
            "parking_count",
            "description",
            "size",
            "price",
            "property_image",
            "property_type",
        ]
