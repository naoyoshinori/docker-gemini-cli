#!/bin/bash -e

BASE_IMAGE="node"
BASE_IMAGE_VERSION="22-bookworm-slim"

SRC_DIR="."

read -p "Do you want to remove package.json and package-lock.json? (y/n) "  -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  exit 0
fi

rm -f "$SRC_DIR/package.json" "$SRC_DIR/package-lock.json"

docker run \
    --rm -v "$SRC_DIR:/app" \
    -w "/app" \
    "$BASE_IMAGE:$BASE_IMAGE_VERSION" \
    bash -c "npm init -y && npm install @google/gemini-cli"

rm -rf "$SRC_DIR/node_modules"
