#!/bin/sh

mkdir -p /tmp/sandman_build

# Update base docker images
echo "-> Updating base docker images"
docker_images=$(podman images | grep docker | cut -d ' ' -f 1)
[ -n "$docker_images" ] && for i in $docker_images; do 
	echo -n "Pulling image $i..."
	if podman image pull $i &> "/tmp/sandman_build/image_$(basename $i).log"; then
		echo " Successful"
	else
		echo " Failed"
	fi
done

# Update base builds
echo "-> Building base sandman images"
base=$(find -L ~/.config/sandman/base -maxdepth 1 -name *.toml | xargs basename -a | cut -d. -f 1)
[ -n "$base" ] && for i in $base; do 
	echo -n "Building base/$i..."
	if sandman build base/$i &> /tmp/sandman_build/base_$i.log; then
		echo " Successful"
	else
		echo " Failed"
	fi
done

# Update builds
echo "-> Building sandman images"
conts=$(find -L ~/.config/sandman -maxdepth 1 -name *.toml | xargs basename -a | cut -d. -f 1)
[ -n "$conts" ] && for i in $conts; do 
	echo -n "Building $i..."
	if sandman build $i &> /tmp/sandman_build/$i.log; then
		#sandman run $i true
		echo " Successful"
	else
		echo " Failed"
	fi
done

echo "-> Pruning dangling images"
podman image prune -f &> /tmp/sandman_build/prune.log

echo "All done."
