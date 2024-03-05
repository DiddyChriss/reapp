#!/bin/bash -e

# Navigate to the .env script directory
cd "$(dirname "$0")"/..

echo "export REPOSITORY_URI=${REPOSITORY_URI}" > .env
echo "export REGION=${REGION}" >> .env
echo "export SECRET_KEY=${SECRET_KEY}" >> .env
echo "export BACKEND_POSTGRES_NAME=${BACKEND_POSTGRES_NAME}" >> .env
echo "export BACKEND_POSTGRES_USER=${BACKEND_POSTGRES_USER}" >> .env
echo "export BACKEND_POSTGRES_PASSWORD=${BACKEND_POSTGRES_PASSWORD}" >> .env
echo "export BACKEND_POSTGRES_HOST=${BACKEND_POSTGRES_HOST}" >> .env
echo "export BACKEND_POSTGRES_PORT=${BACKEND_POSTGRES_PORT}" >> .env
echo "export BACKEND_POSTGRES_SSLMODE=${BACKEND_POSTGRES_SSLMODE}" >> .env
echo "export SUPERUSER_USERNAME=${SUPERUSER_USERNAME}" >> .env
echo "export SUPERUSER_EMAIL=${SUPERUSER_EMAIL}" >> .env
echo "export SUPERUSER_PASSWORD=${SUPERUSER_PASSWORD}" >> .env
