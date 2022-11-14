from rest_framework.serializers import ModelSerializer

from phison_realestate_backend.core.models import Property, PropertyImage


class PropertyImageModelSerializer(ModelSerializer):
    class Meta:
        model = PropertyImage
        fields = [
            "id",
            "image",
            "height",
            "width",
        ]


class PropertyModelSerializer(ModelSerializer):
    images = PropertyImageModelSerializer(many=True)

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
            "images",
        ]
