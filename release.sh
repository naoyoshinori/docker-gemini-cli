#!/bin/bash -e

ENV_DOCKER=".env.docker"

if [ -z "$1" ]; then
  echo "Usage: $0 <base_name>"
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
VERSION_FULL=$(cat "$SRC_DIR/version.txt")
VERSION_SHORT=$(echo "$VERSION_FULL" | cut -d '.' -f 1,2)

echo "Docker registry login"

set +x
echo "$DOCKER_REGISTRY_PASSWORD" | docker login -u "$DOCKER_REGISTRY_USER" --password-stdin $IMAGE_REGISTRY

echo "Docker registry push"

docker push "$IMAGE_NAME:patch-$VERSION_FULL-$IMAGE-$VARIANT"
docker push "$IMAGE_NAME:$VERSION_SHORT-$IMAGE-$VARIANT"
docker push "$IMAGE_NAME:$VERSION_SHORT-$IMAGE"

echo "Docker release done"
