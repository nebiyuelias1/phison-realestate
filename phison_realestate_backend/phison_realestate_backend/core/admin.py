from django.contrib import admin

from .models import BuyerPaymentSchedule, Notification, Property

admin.site.register(Property)
admin.site.register(BuyerPaymentSchedule)
admin.site.register(Notification)
