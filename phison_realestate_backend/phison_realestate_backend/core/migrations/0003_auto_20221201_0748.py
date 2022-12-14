# Generated by Django 3.2.16 on 2022-12-01 07:48

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0002_property_property_type'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='property',
            options={'base_manager_name': 'objects', 'ordering': ['-created_at']},
        ),
        migrations.AddField(
            model_name='buyer',
            name='slug',
            field=models.SlugField(allow_unicode=True, max_length=150, null=True, unique=True),
        ),
    ]
