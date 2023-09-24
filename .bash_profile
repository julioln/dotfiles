export EDITOR=vim

if [[ -z "$SSH_AUTH_SOCK" ]]; then eval `ssh-agent`; fi

if [[ -z "$WAYLAND_DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then 
  export QT_QPA_PLATFORMTHEME=qt5ct
  export GRIM_DEFAULT_DIR=/home/julio/Pictures/Screenshots
  export SDL_VIDEODRIVER=wayland
  export XDG_CURRENT_DESKTOP=sway
  #export WLR_RENDERER=vulkan
  exec systemd-run --user --scope --working-directory /home/julio --slice sway.slice sway --debug
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc

