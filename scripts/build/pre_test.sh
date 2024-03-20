#!/bin/bash -e

# Navigate to the .env script directory
cd "$(dirname "$0")"/../..

# Source environment variables
source ./.env

# Assign image environment variables
REPOSITORY_URI="${REPOSITORY_URI}"
IMAGE_TAG="${IMAGE_TAG}"

# Set the maximum number of attempts
MAX_ATTEMPTS=5

# Set the delay between attempts in seconds
DELAY=10

# Initialize attempt counter
attempt=1

# Login to the Docker registry
scripts/docker_login.sh
