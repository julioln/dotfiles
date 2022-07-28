#!/bin/sh

set -e
set -x

#modename="1366x768_60.00_custom"

[ -z $1 ] && exit 1

#if ! xrandr | grep $modename; then
	#xrandr --newmode $modename 85.25 1366 1440 1576 1784 768 771 781 798 -hsync +vsync && xrandr --addmode $1 $modename
#fi

#xrandr --output $1 --mode $modename --scale 1.2 --gamma 0.8:0.8:0.8
xrandr --output $1 --gamma 0.8 --brightness 0.9
