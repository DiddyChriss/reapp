#!/bin/bash -e

# Your validation logic follows for propertybackend
if docker ps | grep -q propertybackend; then
  echo propertybackend service is running.
else
  echo propertybackend service is not running.
  exit 1
fi

# Your validation logic follows for propertysqldb
if docker ps | grep -q propertysqldb; then
  echo propertysqldb service is running.
else
  echo propertysqldb service is not running.
  exit 1
fi
