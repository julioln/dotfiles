#!/bin/bash

journalctl -f | grep -i pulseaudio | grep --line-buffered Underrun | while read line; do notify-send -u critical -t 5000 "$line"; done
