#!/bin/bash -e

variants=("node" "typescript-node")

for variant in "${variants[@]}"; do
  ./release.sh "$variant"
done
