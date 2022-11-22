from django.db import models


class UserQuerySet(models.QuerySet):
    def get_staff_members(self):
        return self.filter(is_staff=True)

    def get_non_staff_members(self):
        return self.filter(is_staff=False, is_superuser=False)

    def search(self, key):
        return self.filter(
            models.Q(name__icontains=key)
            | models.Q(email__icontains=key)
            | models.Q(phone_number__icontains=key)
        )
