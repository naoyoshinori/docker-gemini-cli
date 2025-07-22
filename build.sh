#!/bin/bash -e

ENV_DOCKER=".env.docker"

if [ -z "$1" ]; then
  echo "Usage: $0 <image>"
  exit 1
fi

SRC_DIR="./src/$1"
BUILD_CONF="$SRC_DIR/build.conf"

if [ ! -f "$ENV_DOCKER" ]; then
  echo "$ENV_DOCKER file not found"
  exit 1
fi

if [ ! -d "$SRC_DIR" ]; then
  echo "Source directory $SRC_DIR does not exist"
  exit 1
fi

if [ ! -f "$BUILD_CONF" ]; then
  echo "$BUILD_CONF file not found"
  exit 1
fi

source "$BUILD_CONF"
source "$ENV_DOCKER"

IMAGE_NAME="${DOCKER_REGISTRY_USER}/gemini-cli"

echo "Docker build"

docker pull "$IMAGE:$VARIANT" || true

docker build --load -t "$IMAGE_NAME:latest" "$SRC_DIR"

docker run -it --rm "$IMAGE_NAME:latest" gemini --version | tr -d "\r\n" > "$SRC_DIR/version.txt"

VERSION_FULL=$(cat "$SRC_DIR/version.txt")
VERSION_SHORT=$(echo "$VERSION_FULL" | cut -d '.' -f 1,2)

docker tag "$IMAGE_NAME:latest" "$IMAGE_NAME:patch-$VERSION_FULL-$IMAGE-$VARIANT"
docker tag "$IMAGE_NAME:latest" "$IMAGE_NAME:$VERSION_SHORT-$IMAGE-$VARIANT"
docker tag "$IMAGE_NAME:latest" "$IMAGE_NAME:$VERSION_SHORT-$IMAGE"

docker rmi "$IMAGE_NAME:latest"

echo "Docker build done"
