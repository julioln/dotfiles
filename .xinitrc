# Environment
export QT_QPA_PLATFORMTHEME=qt5ct
export XCURSOR_THEME=Adwaita
export XCURSOR_SIZE=16

# X11 clients
xhost +local:julio

# Laptop screen color temperature
xrandr --output eDP --gamma 0.9:0.87:0.95

# Screen timeout
xset s 520 60

# Keyboard settings
xset r rate 300 60
setxkbmap -layout us -variant mac -option "lv3:caps_switch"

# Trackpoint
xinput set-prop 'TPPS/2 Elan TrackPoint' 'Coordinate Transformation Matrix' 0.2 0 0 0 0.2 0 0 0 1
xinput set-prop 'TPPS/2 Elan TrackPoint' 'libinput Accel Speed' 0

# Trackpad
xinput set-prop 'SynPS/2 Synaptics TouchPad' 'Coordinate Transformation Matrix' 0.8 0 0 0 0.8 0 0 0 1
xinput set-prop 'SynPS/2 Synaptics TouchPad' 'libinput Accel Speed' 0

# Touchscreen
xinput set-prop 'ELAN Touchscreen' 'Device Enabled' 0

# Background processes
dunst &
nm-applet &
flameshot &
lxqt-policykit-agent &
xss-lock --transfer-sleep-lock -- /usr/local/bin/lock-screen &
update-wallpaper &

# Start
exec i3
