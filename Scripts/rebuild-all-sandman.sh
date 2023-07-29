#!/bin/sh

mkdir -p /tmp/sandman_build

# Update base docker images
echo "-> Updating base docker images"
docker_images=$(podman images | grep docker | cut -d ' ' -f 1)
[ -n "$docker_images" ] && for i in $docker_images; do 
	echo "Pulling image $i..."
	if podman image pull $i &> "/tmp/sandman_build/image_$(basename $i).log"; then
		echo "$i Successful"
	else
		echo "$i Failed"
	fi &
done

wait

# Update base builds
echo "-> Building base sandman images"
base=$(find -L ~/.config/sandman.d/base -maxdepth 1 -name *.toml | xargs basename -a | cut -d. -f 1)
[ -n "$base" ] && for i in $base; do 
	echo "Building base/$i..."
	if sandman build base/$i &> /tmp/sandman_build/base_$i.log; then
		echo "base/$i Successful"
	else
		echo "base/$i Failed"
	fi &
done

wait

# Update builds
echo "-> Building sandman images"
conts=$(find -L ~/.config/sandman.d -maxdepth 1 -name *.toml | xargs basename -a | cut -d. -f 1)
[ -n "$conts" ] && for i in $conts; do 
	echo "Building $i..."
	if sandman build $i &> /tmp/sandman_build/$i.log; then
		echo "$i Successful"
	else
		echo "$i Failed"
	fi &
done

wait

echo "-> Pruning dangling images"
podman image prune -f &> /tmp/sandman_build/prune.log

echo "Preloading images"

sandman start code true &
sandman start discord true & 
sandman start whatsapp true & 
sandman start signal true & 
sandman start telegram true & 
#sandman start hexchat true & 
#sandman start element true & 
sandman start firefox true & 
#sandman start firefox_dev true & 
sandman start chromium true & 
sandman start chrome true & 
sandman start brave true &  
sandman start tidal-git true &  
#sandman start gimp true &  

wait

echo "All done."
