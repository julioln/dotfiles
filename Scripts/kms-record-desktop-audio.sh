#!/bin/sh

set -e

sudo whoami

date=$(date +%F_%H-%M-%S)
d="/home/julio/Videos/capture/$date"

mkdir -p $d

~/Scripts/pulse-desktop-audio-grab.sh "$d/audio.opus" &
sudo ~/Scripts/kmsgrab.sh $1 "$d/video.mp4" &

wait

