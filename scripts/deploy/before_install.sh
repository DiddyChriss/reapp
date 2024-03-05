#!/bin/bash -e

# Set the maximum number of attempts
MAX_ATTEMPTS=5

# Set the delay between attempts in seconds
DELAY=10

# Initialize attempt counter
attempt=1

while true; do
    echo "Attempt $attempt of $MAX_ATTEMPTS: Removing containers and images..."
    docker stop $(docker ps -aq) || true && docker rm $(docker ps -aq) || true && docker rmi $(docker images -q -a) -f || true && break

    if [ "$attempt" -ge "$MAX_ATTEMPTS" ]; then
        echo "Failed to Removing containers and images in after $MAX_ATTEMPTS attempts."
        exit 1
    fi

    echo "Removing containers and images failed. Retrying in $DELAY seconds..."
    attempt=$((attempt+1))
    sleep $DELAY
done

echo "Successfully - containers and images Removed."
