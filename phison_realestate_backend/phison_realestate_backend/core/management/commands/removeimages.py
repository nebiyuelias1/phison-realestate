from typing import Any, Optional

from django.core.management.base import BaseCommand, CommandError

from phison_realestate_backend.core.models import PropertyImage


class Command(BaseCommand):
    help = "Deletes product images that are not linked with a product"

    def handle(self, *args: Any, **options: Any) -> Optional[str]:
        property_images = PropertyImage.objects.filter(property=None)
        property_images_count = property_images.count()

        if property_images_count > 0:
            try:
                property_images.delete()
            except Exception:
                raise CommandError("Something went wrong trying to delete images")

            self.stdout.write(
                self.style.SUCCESS(
                    f"Successfully deleted {property_images_count} property images"
                )
            )
        else:
            self.stdout.write(
                self.style.WARNING(
                    "There are no unlinked property images to be deleted"
                )
            )
