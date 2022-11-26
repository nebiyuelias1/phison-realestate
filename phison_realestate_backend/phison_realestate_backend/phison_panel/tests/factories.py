from factory import Faker
from factory.django import DjangoModelFactory, ImageField

from phison_realestate_backend.core.models import Property, PropertyImage


class PropertyFactory(DjangoModelFactory):
    name = Faker("name")

    size = Faker("pyint", min_value=1)

    price = 2000.0

    slug = Faker("name")

    class Meta:
        model = Property


class PropertyImageFactory(DjangoModelFactory):
    image = ImageField()

    class Meta:
        model = PropertyImage
