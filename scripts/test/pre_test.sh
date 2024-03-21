#!/bin/bash -e

# Navigate to the .env script directory
cd "$(dirname "$0")"/../..

# Source environment variables
source ./.env

echo Setting environment variables...
REPOSITORY_URI="${REPOSITORY_URI}"
IMAGE_TAG="${IMAGE_TAG}"

echo "ECR Repository URI: $REPOSITORY_URI"
echo "Image tag: $IMAGE_TAG"

echo Set timeout to 50 seconds
TIMEOUT=50

echo Pulling the Docker image with a timeout
timeout $TIMEOUT docker pull $REPOSITORY_URI:$IMAGE_TAG && echo "Image pull successful" || (echo "Image pull timed out or failed"; exit 1)
