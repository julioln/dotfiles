#!/bin/sh

# Update base docker images
docker_images=$(podman images | grep docker | cut -d ' ' -f 1)
[ -n "$docker_images" ] && parallel --line-buffer -j '50%' podman image pull {} ::: $docker_images

# Update base sandman builds
base=$(find -L ~/.config/sandman/base -maxdepth 1 -name *.toml | xargs basename -a | cut -d. -f 1)
[ -n "$conts" ] && parallel --line-buffer -j '50%' sandman build base/{} ::: $base

# Update the sandman builds
conts=$(find -L ~/.config/sandman -maxdepth 1 -name *.toml | xargs basename -a | cut -d. -f 1)
[ -n "$conts" ] && parallel --line-buffer -j '50%' sandman build {} ::: $conts

podman image prune -f
