from django.contrib import admin

from .models import BuyerPaymentSchedule, Property

admin.site.register(Property)
admin.site.register(BuyerPaymentSchedule)
