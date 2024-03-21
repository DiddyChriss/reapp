#!/bin/bash

# Source environment variables
source ./.env

echo Docker login script

echo Set the repository URI and region
REPOSITORY_URI="${REPOSITORY_URI}"
REGION="${REGION}"

echo Set timeout to 10 seconds
TIMEOUT=10

echo Run the login command with a timeout
LOGIN_COMMAND=$(aws ecr get-login-password --region $REGION)
if [ $? -eq 0 ]; then
    echo $LOGIN_COMMAND | timeout $TIMEOUT docker login --username AWS --password-stdin $REPOSITORY_URI && echo "Login successful" || (echo "Login command timed out or failed" && exit 1)
else
    echo Failed to retrieve login password
    exit 1
fi

echo Successfully logged in to Docker registry.