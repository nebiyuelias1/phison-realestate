from django.contrib.auth.models import UserManager

from .querysets import UserQuerySet


class UserManager(UserManager.from_queryset(UserQuerySet)):
    """Custom manager for user model."""
