#!/usr/bin/env sh
set -eu

IMAGE_NAME="calculadora-api"
IMAGE_TAG="matheus"
CONTAINER_NAME="calculadora-api"

# Build
docker build -f matheus.Dockerfile -t "$IMAGE_NAME:$IMAGE_TAG" .

# Run (idempotente)
docker rm -f "$CONTAINER_NAME" >/dev/null 2>&1 || true

docker run --name "$CONTAINER_NAME" --rm -p 8080:8080 "$IMAGE_NAME:$IMAGE_TAG"
