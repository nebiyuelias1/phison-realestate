from django.db import models


class PropertyManager(models.Manager):
    def get_queryset(self):
        from .models import PropertyImage

        property_images = PropertyImage.objects.filter(property=models.OuterRef("pk"))

        return (
            super()
            .get_queryset()
            .annotate(
                property_image=models.Subquery(property_images.values("image")[:1])
            )
        )
