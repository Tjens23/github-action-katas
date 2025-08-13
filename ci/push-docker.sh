#!/bin/bash
set -e

# Check if $1 is provided (GitHub repository name)
if [ -z "$1" ]; then
  echo "Error: Repository name not provided"
  echo "Usage: $0 <repository-name>"
  exit 1
fi

# Convert repository name to lowercase for Docker tag
REPO_LOWERCASE=$(echo "$1" | tr '[:upper:]' '[:lower:]')
IMAGE="ghcr.io/${REPO_LOWERCASE}/micronaut-app"

# Login to GitHub Container Registry
echo "$docker_password" | docker login ghcr.io --username "$docker_username" --password-stdin

# Push Docker images
echo "Pushing Docker image: $IMAGE"
[[ -z "$GIT_COMMIT" ]] && Tag='local' || Tag="${GIT_COMMIT::8}"
docker push "$IMAGE:1.0-$Tag"
docker push "$IMAGE:latest" &
wait
