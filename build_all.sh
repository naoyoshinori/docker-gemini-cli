#!/bin/bash -e

variants=("typescript-node" "javascript-node" "node")

for variant in "${variants[@]}"; do
  ./build.sh "$variant"
done
