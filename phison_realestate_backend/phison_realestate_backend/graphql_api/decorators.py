from django.core.exceptions import PermissionDenied


def login_required(func):
    def wrapper(*args, **kwargs):
        user = args[1].context.user
        if not user.is_authenticated:
            raise PermissionDenied("Permission Denied! You must be logged in.")

        return func(*args)

    return wrapper
