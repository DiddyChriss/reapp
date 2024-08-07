from django.db import models
from django.contrib.auth.models import User


class Property(models.Model):
    address = models.CharField(max_length=255)
    postcode = models.CharField(max_length=10)
    city = models.CharField(max_length=100)
    number_of_rooms = models.PositiveIntegerField()
    created_by = models.ForeignKey(User, on_delete=models.CASCADE)

    def __str__(self):
        return self.address
