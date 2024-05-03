#!/bin/bash -e

# Navigate to the .envh script directory
cd "$(dirname "$0")"/../..

# Source environment variables
source ./.env

echo Set the repository URI and region variables
REPOSITORY_URI="${REPOSITORY_URI}"
IMAGE_TAG="${IMAGE_TAG}"

# Login to the Docker registry
scripts/docker_login.sh

echo Set timeout to 50 seconds
TIMEOUT=50

echo Pulling the Docker image with a timeout
timeout $TIMEOUT docker pull $REPOSITORY_URI:$IMAGE_TAG && echo "Image pull successful" || (echo "Image pull timed out or failed"; exit 1)

echo Start the containers with a timeout
docker compose -f docker-compose.staging.yml up -d && echo "Container start successful" || (echo "Container start timed out or failed"; exit 1)
