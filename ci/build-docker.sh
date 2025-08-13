#!/bin/bash
set -e
[[ -z "$GIT_COMMIT" ]] && Tag='local' || Tag="${GIT_COMMIT::8}"
REPO="$1"
# Convert repository name to lowercase for Docker tag
REPO_LOWERCASE=$(echo "$REPO" | tr '[:upper:]' '[:lower:]')
IMAGE="ghcr.io/${REPO_LOWERCASE}/micronaut-app"
echo "Building Docker image: $IMAGE"
docker build -t "$IMAGE:latest" -t "$IMAGE:1.0-$Tag" app/
