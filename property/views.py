from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated

from .models import Property
from .serializers import PropertySerializer


class PropertyViewSet(viewsets.ModelViewSet):
    """
    Simple ModelViewSet class for Property model, requires authentication.
    """
    queryset = Property.objects.all()
    serializer_class = PropertySerializer
    permission_classes = [IsAuthenticated]
