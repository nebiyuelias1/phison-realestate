from django.db import models


class Property(models.Model):
    """A model class that represents a property object."""

    name = models.CharField(null=False, blank=False, max_length=100)

    bed_room_count = models.IntegerField(default=0, null=False, blank=True)

    bath_room_count = models.IntegerField(default=0, null=False, blank=True)

    parking_count = models.IntegerField(default=0, null=False, blank=True)

    description = models.TextField(null=False, blank=False)

    # The unit is in square meters.
    size = models.FloatField(null=False, blank=False)

    # The price is in USD. https://docs.djangoproject.com/en/4.1/ref/models/fields/#decimalfield
    price = models.DecimalField(max_digits=10, decimal_places=2)

    # By default we assume a property is not featured and also it should
    # never be null.
    is_featured = models.BooleanField(null=False, blank=True, default=False)

    progress = models.TextField(null=False, blank=False, max_length=100)


class PropertyImage(models.Model):
    """A model that represents an image for a property."""

    # TODO: Think about resizing the image when storing it.
    # The [width_field] param refers to the field(column) that
    # will be populated with width of the image. The same goes for
    # the [height_field] param.
    image = models.ImageField(
        upload_to="uploads/property_images/",
        null=False,
        blank=False,
        width_field="width",
        height_field="height",
    )

    property = models.ForeignKey(
        Property,
        null=False,
        blank=False,
        related_name="images",
        on_delete=models.CASCADE,
    )

    # The height of the image.
    height = models.IntegerField(editable=False)

    # The width of the image.
    width = models.IntegerField(editable=False)


class PropertyVideo(models.Model):
    """A model that represents a video for a property."""

    video = models.FileField(
        upload_to="uploads_property_videos/", null=False, blank=False
    )

    property = models.ForeignKey(
        Property,
        null=False,
        blank=False,
        related_name="videos",
        on_delete=models.CASCADE,
    )


class PropertyPayment(models.Model):
    """Payment information for a property."""

    title = models.CharField(max_length=100)

    time_period = models.CharField(max_length=100)

    # The amount is in USD.
    amount = models.DecimalField(max_digits=10, decimal_places=2)

    description = models.TextField()

    property = models.ForeignKey(
        Property,
        null=False,
        blank=False,
        related_name="payment_infos",
        on_delete=models.CASCADE,
    )
