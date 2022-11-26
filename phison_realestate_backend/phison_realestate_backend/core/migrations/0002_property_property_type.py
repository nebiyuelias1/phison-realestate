# Generated by Django 3.2.16 on 2022-11-26 12:56

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='property',
            name='property_type',
            field=models.CharField(choices=[('AP', 'Apartment'), ('VI', 'Villa')], default='AP', max_length=2),
        ),
    ]
