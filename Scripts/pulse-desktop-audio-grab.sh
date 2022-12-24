#!/bin/sh

ffmpeg -f pulse -i "$(pactl get-default-sink).monitor" -ab 320k $1
