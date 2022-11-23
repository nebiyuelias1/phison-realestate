from typing import Any, Optional

from django.contrib.auth.mixins import UserPassesTestMixin


class StaffMemberRequiredMixin(UserPassesTestMixin):
    def test_func(self) -> Optional[bool]:
        return self.request.user.is_staff


class PaginateMixin:
    paginate_by = 10

    def get_context_data(self, **kwargs: Any):
        data = super().get_context_data(**kwargs)
        page = data["page_obj"]
        data["prefix"] = range(1, min(4, page.number))
        data["suffix"] = range(
            max(page.number + 1, page.paginator.num_pages - 4),
            page.paginator.num_pages + 1,
        )
        return data
