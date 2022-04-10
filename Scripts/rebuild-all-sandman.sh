#!/bin/sh

docker_images=$(podman images | grep docker | cut -d ' ' -f 1)
[ -n "$docker_images" ] && podman image pull $docker_images

conts=$(find -L ~/.config/sandman -maxdepth 1 -name *.toml | xargs basename -a | cut -d. -f 1)
for s in $conts; do 
	sandman build $s &
done

wait

podman image prune -f
