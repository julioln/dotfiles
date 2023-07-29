export EDITOR=vim
export QT_QPA_PLATFORMTHEME=qt5ct

if [[ -z "$SSH_AUTH_SOCK" ]]; then eval `ssh-agent`; fi

if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty2 ]]; then exec startx; fi

if [[ -z "$WAYLAND_DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then 
  export GRIM_DEFAULT_DIR=/home/julio/Pictures/Screenshots
  export SDL_VIDEODRIVER=wayland
  export XDG_CURRENT_DESKTOP=sway
  export WLR_RENDERER=vulkan
  exec sway --debug &> .log/sway.$(date +%Y%m%d-%H%M%S).log
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc

