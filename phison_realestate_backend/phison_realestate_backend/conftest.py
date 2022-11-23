from io import BytesIO

import pytest
from django.core.files.uploadedfile import SimpleUploadedFile
from PIL import Image

from phison_realestate_backend.users.models import User
from phison_realestate_backend.users.tests.factories import UserFactory


@pytest.fixture(autouse=True)
def media_storage(settings, tmpdir):
    settings.MEDIA_ROOT = tmpdir.strpath


@pytest.fixture
def user(db) -> User:
    return UserFactory()


@pytest.fixture
def temp_image() -> SimpleUploadedFile:
    bts = BytesIO()
    img = Image.new("RGB", (100, 100))
    img.save(bts, "jpeg")
    return SimpleUploadedFile("test.jpg", bts.getvalue())
