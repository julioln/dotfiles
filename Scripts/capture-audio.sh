#!/bin/sh

default_sink=$(pactl get-default-sink)
default_source=$(pactl get-default-source)
date=$(date +%F_%H-%M-%S)

# Audio
ffmpeg -f pulse -i $default_sink.monitor "/home/julio/Videos/capture_audio_${date}.opus"

