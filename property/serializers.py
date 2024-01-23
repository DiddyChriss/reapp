from rest_framework import serializers
from .models import Property


class PropertySerializer(serializers.ModelSerializer):
    """
    Serializer for Property model, additionally validations may be included here.
    """
    class Meta:
        model = Property
        fields = fields = ['id', 'address', 'postcode', 'city', 'number_of_rooms', 'created_by']
