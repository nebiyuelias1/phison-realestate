# Generated by Django 3.2.16 on 2022-11-03 18:55

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0001_initial'),
    ]

    operations = [
        migrations.RenameModel(
            old_name='PropertyPayment',
            new_name='PaymentInformation',
        ),
    ]
