#!/bin/bash

user_cgroup=$(systemctl --user status | grep CGroup | head -n 1 | awk '{print $2}')
app_slice="$user_cgroup/app.slice"
sway_slice="$user_cgroup/sway.slice"

get_scope () {
	grep app.slice /proc/$1/cgroup | cut -d ':' -f 3 | sed 's/\.scope.*/.scope/g'
}

update_weights () {
	echo 1000 > /sys/fs/cgroup$app_slice/cpu.weight
	echo 10000 > /sys/fs/cgroup$sway_slice/cpu.weight

	#echo 
	#echo "Updating weights"
	local tree=$(swaymsg -t get_tree)

	#local focused_pid=$(echo $tree | jq -r '.. | (.nodes? // empty)[] | select(.pid and .focused) | .pid')	
	local visible_pids=$(echo $tree | jq -r '.. | (.nodes? // empty)[] | select(.pid and .visible) | .pid')	

	#echo $visible_pids

	#local focused_scope="/sys/fs/cgroup$(get_scope $focused_pid)"
	#echo "Focused scope: $focused_scope"

	local visible_scopes=()
	for visible_pid in $visible_pids; do
		visible_scopes+=("/sys/fs/cgroup$(get_scope $visible_pid)")
	done	
	#echo "Visible scopes: ${visible_scopes[*]}"

	for s in /sys/fs/cgroup${app_slice}/*.{service,socket}; do
		echo 50 > $s/cpu.weight
	done

	for s in /sys/fs/cgroup${app_slice}/*.scope; do
		#echo "Checking $s"
		#if [ $s == ${focused_scope} ]; then
			#echo "Focused"
			#echo 1000 > $s/cpu.weight
		#elif [[ "${visible_scopes[*]}" =~ $s ]]; then
		if [[ "${visible_scopes[*]}" =~ $s ]]; then
			#echo "Visible"
			echo 1000 > $s/cpu.weight
		else
			#echo "Non visible"
			echo 100 > $s/cpu.weight
		fi
	done
}

update_weights

swaymsg -t subscribe -m "['window']" | jq -r -c --unbuffered '.change' | while read -r change; do
	case $change in
	new | close | focus | move | fullscreen_mode)
	  update_weights ;;
	esac
done &

swaymsg -t subscribe -m "['workspace']" | jq -r -c --unbuffered '.change' | while read -r change; do
	case $change in
	init)
	  update_weights ;;
	esac
done &

wait
