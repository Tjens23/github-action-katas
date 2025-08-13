#!/bin/bash
set -e
[[ -z "$GIT_COMMIT" ]] && Tag='local' || Tag="${GIT_COMMIT::8}"
REPO="$1"
IMAGE="ghcr.io/${REPO}/micronaut-app"
echo "Building Docker image: $IMAGE"
docker build -t "$IMAGE:latest" -t "$IMAGE:1.0-$Tag" app/
