#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set -o noclobber

HISTCONTROL=ignoreboth
HISTSIZE=100000
shopt -s histappend

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias watch='watch '
alias freqs='grep MHz /proc/cpuinfo | tr -d "\t"'
alias youtube-audio='yt-dlp -x --audio-quality 0'
alias paru-update-all='paru --show -w; low-prio paru -Syyyu --batchinstall; sudo pacdiff'
alias extip="curl -s http://checkip.amazonaws.com/"
alias watch-network="sudo watch -t -n 1 'netstat -taupen'"
alias restart-pipewire="systemctl --user restart pipewire.service ; systemctl --user restart pipewire-pulse.service"

alias all-running-containers="podman ps | tail -n +2 | awk '{print \$NF}'"
alias all-containers="podman ps -a | tail -n +2 | awk '{print \$NF}'"
alias all-containers-really="podman ps --all --storage | tail -n +2 | awk '{print \$NF}'"
alias stale-containers="podman ps --filter status=created --format '{{.ID}}'"
alias sandman-build-all-base-arch="podman pull docker.io/library/archlinux ; sandman build base/arch & sandman build base/arch_build & sandman build base/arch_dev & sandman build base/arch_user ; wait"

alias battery-info="find -L /sys/class/power_supply/BAT0 -maxdepth 1 -type f -exec grep '' '{}' \+ | sort"
alias battery-power="cat /sys/class/power_supply/BAT0/power_now"

alias mount-kali-vm="sshfs -o idmap=user kali@kalivm:/home/kali /home/julio/Kali"
alias connect-to-androivm="adb connect androidvm && scrcpy --tcpip=androidvm"
alias connect-to-winvm="xfreerdp /dynamic-resolution /v:winvm /u:fulano"

alias pipe-notify-critical='while read line; do notify-send -u critical "$line"; done'
alias pipe-notify='while read line; do notify-send -u normal "$line"; done'
alias pipe-notify-low='while read line; do notify-send -u low "$line"; done'

alias bellifetch='neofetch --config ~/Desktop/belli_config.conf --source ~/Desktop/belli.txt'
alias mauro="tr a-z A-Z | sed 's/\([^ ]\)/\1 /g' | sed 's/  /.  /g'"

alias based="sandman run based based"

alias notify-command='notify-send -i utilities-terminal "Command finished" "Return code: $?"'

alias weather='curl wttr.in'

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
