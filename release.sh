#!/bin/bash -e

if [ -z "$1" ]; then
  echo "Usage: $0 <base_name>"
  exit 1
fi

BUILD_NAME="$1"
echo "Starting Docker release for '$BUILD_NAME'"

SRC_DIR="./src/$BUILD_NAME"
if [ ! -d "$SRC_DIR" ]; then
  echo "Error: Source directory $SRC_DIR does not exist"
  exit 1
fi

BUILD_CONF="$SRC_DIR/build.conf"
if [ ! -f "$BUILD_CONF" ]; then
  echo "Error: $BUILD_CONF file not found"
  exit 1
fi

source "$BUILD_CONF"

REQUIRED_ENV_VARS=("DOCKER_IMAGE_REGISTRY" "DOCKER_REGISTRY_USER" "DOCKER_REGISTRY_PASSWORD" "BASE_IMAGE" "BASE_IMAGE_VARIANT")
for var in "${REQUIRED_ENV_VARS[@]}"; do
  if [ -z "${!var}" ]; then
    echo "Error: Required environment variable '$var' is not set"
    exit 1
  fi
done

IMAGE_NAME="${DOCKER_REGISTRY_USER}/gemini-cli"
VERSION_FULL=$(cat "$SRC_DIR/version.txt")
VERSION_SHORT=$(echo "$VERSION_FULL" | cut -d '.' -f 1,2)

echo "Docker registry login to '$DOCKER_IMAGE_REGISTRY/$DOCKER_REGISTRY_USER'"

set +x
echo "$DOCKER_REGISTRY_PASSWORD" | docker login -u "$DOCKER_REGISTRY_USER" --password-stdin $DOCKER_IMAGE_REGISTRY

echo "Pushing Docker image: '$IMAGE_NAME' with base image '$BASE_IMAGE:$BASE_IMAGE_VARIANT'"

echo "Pushing image as '$IMAGE_NAME:patch-$VERSION_FULL-$BASE_IMAGE-$BASE_IMAGE_VARIANT'"
docker push "$IMAGE_NAME:patch-$VERSION_FULL-$BASE_IMAGE-$BASE_IMAGE_VARIANT"

echo "Pushing image as '$IMAGE_NAME:$VERSION_SHORT-$BASE_IMAGE-$BASE_IMAGE_VARIANT'"
docker push "$IMAGE_NAME:$VERSION_SHORT-$BASE_IMAGE-$BASE_IMAGE_VARIANT"

echo "Pushing image as '$IMAGE_NAME:$VERSION_SHORT-$BASE_IMAGE'"
docker push "$IMAGE_NAME:$VERSION_SHORT-$BASE_IMAGE"

echo "Docker release completed successfully for '$BUILD_NAME'."
