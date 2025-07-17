#!/bin/bash -e

variants=("node" "typescript-node")

for variant in "${variants[@]}"; do
  ./build.sh "$variant"
done
