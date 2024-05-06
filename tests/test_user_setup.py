import pytest
from django.contrib.auth import get_user_model
from rest_framework.test import APIClient


User = get_user_model()


class UserSetup:
    @pytest.fixture
    def admin_user(self):
        return User.objects.create_superuser(
            username="admin", password="adminpass", email="admin@example.com"
        )

    @pytest.fixture
    def non_admin_user(self):
        return User.objects.create_user(
            username="user", password="userpass", email="user@example.com"
        )

    @pytest.fixture
    def api_client(self):
        return APIClient()
