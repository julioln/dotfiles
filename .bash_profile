export EDITOR=vim

if [[ -z "$SSH_AUTH_SOCK" ]]; then eval `ssh-agent`; fi
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then exec startx; fi

[[ -f ~/.bashrc ]] && . ~/.bashrc

