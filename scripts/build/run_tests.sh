#!/bin/bash -e

# Navigate to the .env script directory
cd "$(dirname "$0")"/../..

# Source environment variables
source ./.env

REPOSITORY_URI="${REPOSITORY_URI}"
IMAGE_TAG="${IMAGE_TAG}"

echo pull image..
docker pull $REPOSITORY_URI:$IMAGE_TAG

echo Run containers..
docker compose -f docker-compose.staging.yml up -d

echo Run tests...
docker compose run propertybackend pytest
