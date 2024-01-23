import pytest
from rest_framework import status

from tests.test_user_setup import UserSetup


@pytest.mark.django_db
class TestAdminUser(UserSetup):
    def test_admin_can_create_user(self, api_client, admin_user):
        api_client.force_authenticate(user=admin_user)

        data = {
            'username': 'newuser',
            'password': 'newuserpass',
            'email': 'newuser@example.com'
        }

        response = api_client.post('/api/users/', data)
        assert response.status_code == status.HTTP_201_CREATED

    def test_non_admin_cannot_create_user(self, api_client, non_admin_user):
        api_client.force_authenticate(user=non_admin_user)

        data = {
            'username': 'newuser',
            'password': 'newuserpass',
            'email': 'newuser@example.com'
        }

        response = api_client.post('/api/users/', data)
        assert response.status_code == status.HTTP_403_FORBIDDEN
        assert response.data['detail'] == 'You do not have permission to perform this action.'

    def test_admin_can_delete_user(self, api_client, admin_user, non_admin_user):
        api_client.force_authenticate(user=admin_user)

        response = api_client.delete(f'/api/users/{non_admin_user.id}/')
        assert response.status_code == status.HTTP_204_NO_CONTENT

    def test_non_admin_cannot_delete_user(self, api_client, non_admin_user):
        api_client.force_authenticate(user=non_admin_user)

        response = api_client.delete(f'/api/users/{non_admin_user.id}/')
        assert response.status_code == status.HTTP_403_FORBIDDEN
        assert response.data['detail'] == 'You do not have permission to perform this action.'

    def test_admin_can_list_users(self, api_client, admin_user):
        api_client.force_authenticate(user=admin_user)

        response = api_client.get('/api/users/')
        assert response.status_code == status.HTTP_200_OK

    def test_non_admin_cannot_list_users(self, api_client, non_admin_user):
        api_client.force_authenticate(user=non_admin_user)

        response = api_client.get('/api/users/')
        assert response.status_code == status.HTTP_403_FORBIDDEN
        assert response.data['detail'] == 'You do not have permission to perform this action.'
