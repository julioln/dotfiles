#!/bin/sh

res="w=2560:h=1080"
date=$(date +%F_%H-%M-%S)

# Video
ffmpeg -device /dev/dri/card0 -f kmsgrab -i - -vf "hwmap=derive_device=vaapi,scale_vaapi=${res}:format=nv12" -c:v h264_vaapi -qp 24 "/home/julio/Videos/capture_video_${date}.mp4"

