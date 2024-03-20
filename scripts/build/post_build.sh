#!/bin/bash -e

# Navigate to the .env script directory
cd "$(dirname "$0")"/../..

# Source environment variables
source ./.env

REPOSITORY_URI="${REPOSITORY_URI}"
IMAGE_TAG="${IMAGE_TAG}"

echo Pushing the Docker image...
docker push $REPOSITORY_URI:$IMAGE_TAG
echo Build and push process completed.
