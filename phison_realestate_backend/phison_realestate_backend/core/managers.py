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


class BuyerManager(models.Manager):
    def get_queryset(self):
        from .models import BuyerPaymentSchedule

        payment_schedule = BuyerPaymentSchedule.objects.filter(
            buyer=models.OuterRef("pk")
        ).values("buyer")
        complete_payment_schedule = payment_schedule.filter(
            status=BuyerPaymentSchedule.COMPLETE
        )

        payment_schedule_count = payment_schedule.annotate(
            count=models.Count("status")
        ).values("count")
        complete_payment_schedule_count = complete_payment_schedule.annotate(
            count=models.Count("status")
        ).values("count")

        return (
            super()
            .get_queryset()
            .annotate(
                payment_schedule_count=models.Subquery(payment_schedule_count),
                complete_payment_schedule_count=complete_payment_schedule_count,
                completed_percentage=(
                    models.F("complete_payment_schedule_count")
                    / models.F("payment_schedule_count")
                    * 100
                ),
            )
        )
