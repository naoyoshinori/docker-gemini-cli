#!/bin/bash -e

if [ -z "$1" ]; then
  echo "Usage: $0 <build_name>"
  exit 1
fi

BUILD_NAME="$1"
echo "Starting Docker build for '$BUILD_NAME'"

SRC_DIR="./src/$BUILD_NAME"
if [ ! -d "$SRC_DIR" ]; then
  echo "Error: Source directory '$SRC_DIR' does not exist"
  exit 1
fi

BUILD_CONF="$SRC_DIR/build.conf"
if [ ! -f "$BUILD_CONF" ]; then
  echo "Error: $BUILD_CONF file not found"
  exit 1
fi
source "$BUILD_CONF"

REQUIRED_ENV_VARS=("DOCKER_REGISTRY_USER" "BASE_IMAGE" "BASE_IMAGE_VARIANT")
for var in "${REQUIRED_ENV_VARS[@]}"; do
  if [ -z "${!var}" ]; then
    echo "Error: Required environment variable '$var' is not set"
    exit 1
  fi
done

IMAGE_NAME="${DOCKER_REGISTRY_USER}/gemini-cli"

echo "Building Docker image: '$IMAGE_NAME' with base image '$BASE_IMAGE:$BASE_IMAGE_VARIANT'"
docker build --no-cache --load -t "$IMAGE_NAME:latest" "$SRC_DIR"

echo "Extracting Gemini CLI version from the image"
docker run --rm "$IMAGE_NAME:latest" gemini --version | tr -d "\r\n" > "$SRC_DIR/version.txt"

VERSION_FULL=$(cat "$SRC_DIR/version.txt")
VERSION_SHORT=$(echo "$VERSION_FULL" | cut -d '.' -f 1,2)
echo "Gemini CLI version: $VERSION_FULL"

echo "Tagging image as '$IMAGE_NAME:patch-$VERSION_FULL-$BASE_IMAGE-$BASE_IMAGE_VARIANT'"
docker tag "$IMAGE_NAME:latest" "$IMAGE_NAME:patch-$VERSION_FULL-$BASE_IMAGE-$BASE_IMAGE_VARIANT"

echo "Tagging image as '$IMAGE_NAME:$VERSION_SHORT-$BASE_IMAGE-$BASE_IMAGE_VARIANT'"
docker tag "$IMAGE_NAME:latest" "$IMAGE_NAME:$VERSION_SHORT-$BASE_IMAGE-$BASE_IMAGE_VARIANT"

echo "Tagging image as '$IMAGE_NAME:$VERSION_SHORT-$BASE_IMAGE'"
docker tag "$IMAGE_NAME:latest" "$IMAGE_NAME:$VERSION_SHORT-$BASE_IMAGE"

docker rmi "$IMAGE_NAME:latest" >/dev/null || true

echo "Docker build completed successfully for '$BUILD_NAME'."
