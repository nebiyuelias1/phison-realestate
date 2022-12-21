import json

from django.core import mail
from django.core.mail import EmailMultiAlternatives
from django.template.loader import render_to_string

from phison_realestate_backend.core.models import Notification


def notify_buyers_about_due_payment(context_list):
    connection = mail.get_connection()

    msgs = []
    notifications = []

    for item in context_list:
        body = render_to_string("email/buyer_due_payment.txt", item).strip()
        msg = EmailMultiAlternatives(
            "Reminder about due payment", body=body, to=[item["buyer__customer__email"]]
        )
        msg.attach_alternative(body, "text/html")

        msgs.append(msg)

        notification = Notification(
            user_id=item["buyer__customer__pk"],
            notification_type=Notification.PAYMENT_DUE,
            data=json.dumps(item, indent=4, sort_keys=True, default=str),
        )
        notifications.append(notification)

    # Create in app notification objects
    Notification.objects.bulk_create(notifications)

    # Send the two emails in a single call
    connection.send_messages(msgs)
    # The connection was already open so send_messages() doesn't close it.
    # We need to manually close the connection.
    connection.close()
