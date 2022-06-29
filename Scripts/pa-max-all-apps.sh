#!/bin/sh
pactl list sink-inputs | grep 'Sink Input #' | cut -d '#' -f 2 | xargs -I {} pactl set-sink-input-volume {} 100%
