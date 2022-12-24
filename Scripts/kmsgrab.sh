#!/bin/sh

plane=$1
shift
ffmpeg -framerate 60 -plane_id $plane -f kmsgrab -i - -vaapi_device /dev/dri/renderD128 -vf 'hwmap=derive_device=vaapi,scale_vaapi=format=nv12,hwupload' -qp 30 -profile:v main -c:v hevc_vaapi $@
