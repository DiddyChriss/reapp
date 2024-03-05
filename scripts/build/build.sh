#!/bin/bash -e

# Navigate to the .env script directory
cd "$(dirname "$0")"/../..

# Source environment variables
source ./.env

REPOSITORY_URI="${REPOSITORY_URI}"
IMAGE_TAG="${IMAGE_TAG}"

echo Building the Docker image...
docker compose -f docker-compose.staging.yml build

echo "Printing images..."
docker images
