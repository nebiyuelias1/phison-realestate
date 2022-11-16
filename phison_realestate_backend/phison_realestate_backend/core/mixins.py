from typing import Optional

from django.contrib.auth.mixins import UserPassesTestMixin


class StaffMemberRequiredMixin(UserPassesTestMixin):
    def test_func(self) -> Optional[bool]:
        return self.request.user.is_staff
