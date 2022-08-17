#!/bin/bash

journalctl -f | grep -i pulseaudio | grep --line-buffered Underrun | while read line; do notify-send -u low -t 1000 "$line"; done
