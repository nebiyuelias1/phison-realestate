from django.contrib import auth


class FirebaseAuthorizationMiddleware:
    def resolve(self, next, root, info, **kwargs):
        context = info.context

        user = auth.authenticate(request=context, **kwargs)
        if user:
            context.user = user

        return next(root, info, **kwargs)
