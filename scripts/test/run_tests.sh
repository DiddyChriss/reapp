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

echo Run tests with a timeout
timeout $TIMEOUT docker compose -f docker-compose.staging.yml run propertybackend sh -c "cd /usr/src/reapp && pwd && ls -la && pytest" && echo "Run tests successful" || (echo "Run tests timed out or failed"; exit 1)
