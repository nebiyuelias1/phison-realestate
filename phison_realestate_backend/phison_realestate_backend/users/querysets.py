from django.db import models


class UserQuerySet(models.QuerySet):
    def get_staff_members(self):
        return self.filter(is_staff=True)

    def get_non_staff_members(self):
        return self.filter(is_staff=False, is_superuser=False)
