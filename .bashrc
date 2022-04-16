#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set -o noclobber

alias ls='ls --color=auto'

alias watch='watch '
alias freqs='grep MHz /proc/cpuinfo | tr -d "\t"'
alias youtube-mp3='youtube-dl -x --audio-format mp3 --audio-quality 0'
#alias yay-update-all='low-prio yay -Syu --batchinstall'
alias paru-update-all='low-prio paru -Syu --batchinstall'
alias extip="curl -s http://checkip.amazonaws.com/"
alias watch-network="sudo watch -t -n 1 'netstat -taupen'"
alias all-running-containers="podman ps | tail -n +2 | awk '{print \$NF}'"
alias all-containers="podman ps -a | tail -n +2 | awk '{print \$NF}'"
alias all-containers-really="podman ps --all --storage | tail -n +2 | awk '{print \$NF}'"
alias mount-kali-vm="sshfs -o idmap=user kali@kalivm:/home/kali /home/julio/Kali"
alias battery-info="find -L /sys/class/power_supply/BAT0 -maxdepth 1 -type f -exec grep '' '{}' \+ | sort"
alias battery-power="cat /sys/class/power_supply/BAT0/power_now"

alias pipe-notify-critical='while read line; do notify-send -u critical -t 5000 "$line"; done'
alias pipe-notify='while read line; do notify-send -u normal -t 3000 "$line"; done'
alias pipe-notify-low='while read line; do notify-send -u low -t 2000 "$line"; done'

alias bellifetch='neofetch --config ~/Desktop/belli_config.conf --source ~/Desktop/belli.txt'
alias mauro="tr a-z A-Z | sed 's/\([^ ]\)/\1 /g' | sed 's/  /.  /g'"


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
