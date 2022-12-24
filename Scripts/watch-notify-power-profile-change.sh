#!/bin/bash

last=""
current=""

while true; do
	current=$(cat /sys/firmware/acpi/platform_profile)

	if ! [ "$last" = "$current" ]; then
		if [ $(cat /sys/devices/platform/thinkpad_acpi/dytc_lapmode) = "1" ]; then
			lapmode="enabled"
		else
			lapmode="disabled"
		fi
		notify-send -i "battery" "Power Profile" "Changed to: ${current}\nLapmode: ${lapmode}"
	fi
	
	last=$current
	sleep 10
done
