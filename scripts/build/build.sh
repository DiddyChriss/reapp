#!/bin/bash -e

# Navigate to the .env script directory
cd "$(dirname "$0")"/../..

# Source environment variables
source ./.env

echo Setting ECR environment variables...
REPOSITORY_URI="${REPOSITORY_URI}"
IMAGE_TAG="${IMAGE_TAG}"

echo Building the Docker image with a timeout
docker compose -f docker-compose.staging.yml build
echo Docker image built successfully

echo Printing images...
docker images
