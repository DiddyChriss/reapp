#!/bin/bash -e

# Navigate to the .env script directory
cd "$(dirname "$0")"/../..

# Source environment variables
source ./.env

echo Setting ECR environment variables...
REPOSITORY_URI="${REPOSITORY_URI}"
IMAGE_TAG="${IMAGE_TAG}"

echo Set timeout to 30 seconds
TIMEOUT=30

echo Pushing the Docker image with a timeout
timeout $TIMEOUT docker push $REPOSITORY_URI:$IMAGE_TAG && echo "Image push successful" || (echo "Image push timed out or failed"; exit 1)
