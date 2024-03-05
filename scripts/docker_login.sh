#!/bin/bash

# Source environment variables
source ./.env

# Set the repository URI and region
REPOSITORY_URI="${REPOSITORY_URI}"
REGION="${REGION}"

# Set the maximum number of attempts
MAX_ATTEMPTS=5

# Set the delay between attempts in seconds
DELAY=10

# Initialize attempt counter
attempt=1

while true; do
    echo "Attempt $attempt of $MAX_ATTEMPTS: Logging in to Docker registry..."
    aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $REPOSITORY_URI && break

    if [ "$attempt" -ge "$MAX_ATTEMPTS" ]; then
        echo "Failed to log in after $MAX_ATTEMPTS attempts."
        exit 1
    fi

    echo "Login attempt failed. Retrying in $DELAY seconds..."
    attempt=$((attempt+1))
    sleep $DELAY
done

echo "Successfully logged in to Docker registry."
