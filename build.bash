#!/usr/bin/env bash

# Builds a Docker image.
image_name=dock_px4
distro=$(basename $1)

if [ $# -lt 1 ]
then
    echo "Usage: $0 <path to directory containing Dockerfile>"
    exit 1
fi

if [ ! -f "${1}"/Dockerfile ]
then
    echo "Err: Directory does not contain a Dockerfile to build."
    exit 1
fi

image_plus_tag=$image_name:$(export LC_ALL=C; date +%Y_%m_%d_%H%M)
docker build --rm -t $image_plus_tag -f "${1}"/Dockerfile "${1}" && \
docker tag $image_plus_tag $image_name:$distro && \
echo "Built $image_plus_tag and tagged as $image_name:$distro"
echo "To run:"
echo "./run.bash $image_name:$distro"
