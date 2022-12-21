from datetime import timedelta
from typing import Any, Optional

from django.core.management.base import BaseCommand, CommandError
from django.db.models import ExpressionWrapper, F, fields
from django.db.models.functions import Now

from phison_realestate_backend.core.models import BuyerPaymentSchedule
from phison_realestate_backend.core.utils import notify_buyers_about_due_payment


class Command(BaseCommand):
    help = "Send notification to buyers about due payment"

    def handle(self, *args: Any, **options: Any) -> Optional[str]:
        duration = ExpressionWrapper(
            F("deadline") - F("today"), output_field=fields.DurationField()
        )

        payment_schedules = BuyerPaymentSchedule.objects.annotate(
            today=Now(), duration=duration
        ).filter(
            status=BuyerPaymentSchedule.PENDING,
            duration__lte=timedelta(days=7),
            duration__gt=timedelta(days=0),
            is_notification_sent=False,
        )
        payment_schedules_count = payment_schedules.count()
        if payment_schedules_count > 0:
            try:
                context_list = list(
                    payment_schedules.values(
                        "buyer__customer__name",
                        "buyer__customer__pk",
                        "duration",
                        "buyer__customer__email",
                        "buyer__property__property_type",
                        "deadline",
                        "amount",
                    )
                )

                notify_buyers_about_due_payment(context_list)

                payment_schedules.update(is_notification_sent=True)

                self.stdout.write(
                    self.style.SUCCESS(
                        f"Successfully sent notifications to {payment_schedules_count} buyer(s)"
                    )
                )
            except Exception as e:
                raise CommandError(
                    "Something went wrong trying to send notifications", e
                )
        else:
            self.stdout.write(
                self.style.NOTICE("There are no notifications to be sent")
            )
