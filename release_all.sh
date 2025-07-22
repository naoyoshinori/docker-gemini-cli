#!/bin/bash -e

variants=("typescript-node" "javascript-node" "node")

for variant in "${variants[@]}"; do
  ./release.sh "$variant"
done
