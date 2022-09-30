### Environment
export QT_QPA_PLATFORMTHEME=qt5ct
export XCURSOR_THEME=Adwaita
export XCURSOR_SIZE=16
export CM_LAUNCHER=rofi
export CM_HISTLENGTH=20
export CM_DIR=/var/local/julio
export CM_MAX_CLIPS=10000
export XDG_CURRENT_DESKTOP=i3
export XDG_SESSION_TYPE=x11

systemctl --user import-environment DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE

### X11 setup

# X11 clients
xhost +local:julio

# Laptop screen color temperature
xrandr --output eDP --gamma 0.9:0.87:0.95

# Screen timeout
xset s 900
xset dpms 0 0 915

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

# Disable system beep
xset -b

### Background processes
nice -n -10 xss-lock --transfer-sleep-lock -- /opt/local/bin/lock-screen &
nice -n -5 lxqt-policykit-agent &
sandman run kdeconnect &
nm-applet &
flameshot &
dunst &
blueman-applet &
#pasystray &
nice -n 5 clipmenud &
nice -n 5 /usr/lib/xdg-desktop-portal &
nice -n 10 update-wallpaper &

### Start
exec i3
