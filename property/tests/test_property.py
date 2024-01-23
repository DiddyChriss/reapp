import pytest

from property.models import Property
from property.serializers import PropertySerializer
from tests.test_user_setup import UserSetup


@pytest.mark.django_db
class TestProperty(UserSetup):
    def test_property_serializer(self, api_client, admin_user):
        property_data = {
            'address': '123 Main St',
            'postcode': '12345',
            'city': 'Test City',
            'number_of_rooms': 3,
            'created_by': admin_user.id,
        }

        serializer = PropertySerializer(data=property_data)

        # Check if serializer is valid
        assert serializer.is_valid()

        # Save the property to the database
        property_instance = serializer.save()

        # Check if the fields are correctly serialized
        assert serializer.data['address'] == '123 Main St'
        assert serializer.data['postcode'] == '12345'
        assert serializer.data['city'] == 'Test City'
        assert serializer.data['number_of_rooms'] == 3
        assert serializer.data['created_by'] == admin_user.id

        # Check if the property is saved in the database
        assert Property.objects.filter(id=property_instance.id).exists()
