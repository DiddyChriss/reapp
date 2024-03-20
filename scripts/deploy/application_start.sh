#!/bin/bash -e

# Navigate to the .envh script directory
cd "$(dirname "$0")"/../..

# Source environment variables
source ./.env

# Set the repository URI and region
REPOSITORY_URI="${REPOSITORY_URI}"
REGION="${REGION}"
IMAGE_TAG="${IMAGE_TAG}"

# Login to the Docker registry
scripts/docker_login.sh

# Pull the latest image
docker pull $REPOSITORY_URI:$IMAGE_TAG

# Run containers
docker compose -f docker-compose.staging.yml up -d
