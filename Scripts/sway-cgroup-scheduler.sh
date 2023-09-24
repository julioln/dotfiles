#!/bin/sh

user_cgroup=$(systemctl --user status | grep CGroup | head -n 1 | awk '{print $2}')
app_slice="$user_cgroup/app.slice"
sway_slice="$user_cgroup/sway.slice"

echo 1000 > /sys/fs/cgroup$app_slice/cpu.weight
echo 3000 > /sys/fs/cgroup$sway_slice/cpu.weight

swaymsg -t subscribe -m "['window']" | jq -c --unbuffered 'select(.change | contains("focus")) | .container.pid' | while read -r pid; do
	cgroup=$(grep app.slice /proc/$pid/cgroup | cut -d ':' -f 3)
	scope=$(echo $cgroup | sed 's/\.scope.*/.scope/g')
	#echo "Changed focus"
	#echo "Pid: $pid"
	#echo "Cgroup: $cgroup"
	#echo "Scope: $scope"
	#echo "Slice: $slice"

	for s in /sys/fs/cgroup${app_slice}/*.{scope,service,socket}; do
		echo 100 > $s/cpu.weight
	done

	if [ -n "$scope" ]; then
		echo 1000 > /sys/fs/cgroup$scope/cpu.weight
	fi
done
