from django.contrib.auth import get_user_model
from django.db import models
from django.urls import reverse

User = get_user_model()


class TimeStampedModel(models.Model):
    """A base model for saving timing information."""

    # https://docs.djangoproject.com/en/4.1/ref/models/fields/#django.db.models.DateField.auto_now_add
    created_at = models.DateTimeField(auto_now_add=True)

    # https://docs.djangoproject.com/en/4.1/ref/models/fields/#django.db.models.DateField.auto_now
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True


# TODO: Add property_type to this model with options: apartment or villa
class Property(TimeStampedModel):
    APARTMENT = "AP"
    VILLA = "VI"

    """A model class that represents a property object."""

    name = models.CharField(null=False, blank=False, max_length=100)

    bed_room_count = models.PositiveSmallIntegerField(default=0, null=False, blank=True)

    bath_room_count = models.PositiveSmallIntegerField(
        default=0, null=False, blank=True
    )

    parking_count = models.PositiveSmallIntegerField(default=0, null=False, blank=True)

    description = models.TextField(null=False, blank=False)

    # The unit is in square meters.
    size = models.FloatField(null=False, blank=False)

    # The price is in USD. https://docs.djangoproject.com/en/4.1/ref/models/fields/#decimalfield
    price = models.DecimalField(max_digits=10, decimal_places=2)

    # By default we assume a property is not featured and also it should never be null.
    is_featured = models.BooleanField(null=False, blank=True, default=False)

    progress = models.TextField(null=False, blank=False, max_length=100)

    def get_absolute_url(self):
        # TODO: Modify this URL to the detail of the property.
        return reverse("phison_panel:home")

    class Meta:
        # https://docs.djangoproject.com/en/4.1/ref/models/options/
        ordering = ["-created_at"]


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


class PaymentInformation(models.Model):
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


class Buyer(TimeStampedModel):
    """A model that represents a customer that has bought a property."""

    property = models.ForeignKey(
        Property,
        related_name="buyers",
        null=True,
        blank=False,
        on_delete=models.SET_NULL,
    )

    customer = models.ForeignKey(
        User,
        related_name="bought_properties",
        null=True,
        blank=False,
        on_delete=models.SET_NULL,
    )

    # The staff user that made the registration.
    registered_by = models.ForeignKey(
        User, related_name="+", null=True, blank=False, on_delete=models.SET_NULL
    )

    class Meta:
        # https://docs.djangoproject.com/en/4.1/ref/models/options/
        ordering = ["-created_at"]


class BuyerPaymentSchedule(TimeStampedModel):
    """A model that represents payment schedule for a buyer."""

    PENDING = "PE"
    COMPLETE = "CP"

    PAYMENT_STATUS_OPTIONS = [
        (PENDING, "Pending"),
        (COMPLETE, "Complete"),
    ]

    title = models.CharField(max_length=100)

    description = models.TextField()

    buyer = models.ForeignKey(
        Buyer,
        related_name="schedules",
        null=False,
        blank=False,
        on_delete=models.CASCADE,
    )

    percentage = models.FloatField()

    # The amount is in USD.
    amount = models.DecimalField(max_digits=10, decimal_places=2)

    deadline = models.DateTimeField(null=False, blank=False)

    status = models.CharField(
        max_length=2, choices=PAYMENT_STATUS_OPTIONS, default=PENDING
    )
