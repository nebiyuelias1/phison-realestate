# Generated by Django 3.2.16 on 2022-11-06 18:24

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0002_rename_propertypayment_paymentinformation'),
    ]

    operations = [
        migrations.AlterField(
            model_name='property',
            name='bath_room_count',
            field=models.PositiveSmallIntegerField(blank=True, default=0),
        ),
        migrations.AlterField(
            model_name='property',
            name='bed_room_count',
            field=models.PositiveSmallIntegerField(blank=True, default=0),
        ),
        migrations.AlterField(
            model_name='property',
            name='parking_count',
            field=models.PositiveSmallIntegerField(blank=True, default=0),
        ),
    ]