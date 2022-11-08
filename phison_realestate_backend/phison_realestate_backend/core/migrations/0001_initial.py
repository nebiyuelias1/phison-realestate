# Generated by Django 3.2.16 on 2022-11-03 18:50

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Property',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('bed_room_count', models.IntegerField(blank=True, default=0)),
                ('bath_room_count', models.IntegerField(blank=True, default=0)),
                ('parking_count', models.IntegerField(blank=True, default=0)),
                ('description', models.TextField()),
                ('size', models.FloatField()),
                ('price', models.DecimalField(decimal_places=2, max_digits=10)),
                ('is_featured', models.BooleanField(blank=True, default=False)),
                ('progress', models.TextField(max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name='PropertyVideo',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('video', models.FileField(upload_to='uploads_property_videos/')),
                ('property', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='videos', to='core.property')),
            ],
        ),
        migrations.CreateModel(
            name='PropertyPayment',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=100)),
                ('time_period', models.CharField(max_length=100)),
                ('amount', models.DecimalField(decimal_places=2, max_digits=10)),
                ('description', models.TextField()),
                ('property', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='payment_infos', to='core.property')),
            ],
        ),
        migrations.CreateModel(
            name='PropertyImage',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('image', models.ImageField(height_field='height', upload_to='uploads/property_images/', width_field='width')),
                ('height', models.IntegerField(editable=False)),
                ('width', models.IntegerField(editable=False)),
                ('property', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='images', to='core.property')),
            ],
        ),
    ]