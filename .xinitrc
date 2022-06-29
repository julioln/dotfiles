### Environment
export QT_QPA_PLATFORMTHEME=qt5ct
export XCURSOR_THEME=Adwaita
export XCURSOR_SIZE=16
export CM_LAUNCHER=rofi
export CM_HISTLENGTH=15

### X11 setup

# X11 clients
xhost +local:julio

# Laptop screen color temperature
xrandr --output eDP --gamma 0.9:0.87:0.95

# Screen timeout
xset s 900 0

# Keyboard settings
xset r rate 300 60
setxkbmap -layout us -variant mac -option "lv3:caps_switch" -option "terminate:ctrl_alt_bksp"

# Trackpoint
xinput set-prop 'TPPS/2 Elan TrackPoint' 'Coordinate Transformation Matrix' 0.2 0 0 0 0.2 0 0 0 1
xinput set-prop 'TPPS/2 Elan TrackPoint' 'libinput Accel Speed' 0

# Trackpad
xinput set-prop 'SynPS/2 Synaptics TouchPad' 'Coordinate Transformation Matrix' 0.8 0 0 0 0.8 0 0 0 1
xinput set-prop 'SynPS/2 Synaptics TouchPad' 'libinput Accel Speed' 0

# Touchscreen
xinput set-prop 'ELAN Touchscreen' 'Device Enabled' 0

### Background processes
#xiccd &
nice clipmenud &
nice sandman run kdeconnect &
dunst &
nm-applet &
blueman-applet &
update-wallpaper &
flameshot &
lxqt-policykit-agent &
xss-lock --transfer-sleep-lock -- /opt/local/bin/lock-screen &

### Start
exec i3
