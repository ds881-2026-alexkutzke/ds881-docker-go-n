#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="calculadora-api"
DOCKERFILE="joelintonDorte.Dockerfile"
CONTAINER_NAME="calculadora-api-container"

# Remove imagem antiga
docker image rm -f "$IMAGE_NAME" 2>/dev/null || true

# Constroi a imagem Docker
docker build -t "$IMAGE_NAME" -f "$DOCKERFILE" .

# Remove container antigo
docker rm -f "$CONTAINER_NAME" 2>/dev/null || true

# Roda o container
docker run -d --name "$CONTAINER_NAME" -p 8080:8080 "$IMAGE_NAME"

