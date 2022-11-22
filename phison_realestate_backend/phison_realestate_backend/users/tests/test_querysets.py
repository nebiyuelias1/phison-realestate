import pytest
from django.contrib.auth import get_user_model

User = get_user_model()


@pytest.mark.django_db
class TestUserQuerySet:
    def test_get_staff_members_check_count_is_zero(self, user: User):
        users = User.objects.get_staff_members()
        assert users.count() == 0

    def test_get_staff_members_check_count_is_one(self, user: User):
        user.is_staff = True
        user.save()

        users = User.objects.get_staff_members()
        assert users.count() == 1

    def test_get_non_staff_members_count_should_be_one(self, user: User):
        users = User.objects.get_non_staff_members()
        assert users.count() == 1

    def test_get_non_staff_members_count_should_be_zero(self, user: User):
        user.is_staff = True
        user.save()

        users = User.objects.get_non_staff_members()
        assert users.count() == 0

        user.is_staff = False
        user.is_superuser = True
        user.save()
        users = User.objects.get_non_staff_members()
        assert users.count() == 0

        user.is_staff = True
        user.is_superuser = True
        user.save()
        users = User.objects.get_non_staff_members()
        assert users.count() == 0
