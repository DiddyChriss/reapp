#!/bin/bash -e

# Navigate to the .env script directory
cd "$(dirname "$0")"/../..

# Source environment variables
source ./.env

# Set the image tag and export it to an environment variable
IMAGE_TAG=$(date +%Y%m%d%H%M%S)
echo "export IMAGE_TAG=${IMAGE_TAG}" >> .env
