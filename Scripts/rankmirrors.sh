#!/bin/bash

set -e

m=$(mktemp)

cleanup () {
  rm -f $m
}
trap cleanup EXIT

sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup

awk '/^## Canada$/{f=1; next}f==0{next}/^$/{exit}{print substr($0, 1);}' /etc/pacman.d/mirrorlist.backup >> $m
awk '/^## Worldwide$/{f=1; next}f==0{next}/^$/{exit}{print substr($0, 1);}' /etc/pacman.d/mirrorlist.backup >> $m
awk '/^## United States$/{f=1; next}f==0{next}/^$/{exit}{print substr($0, 1);}' /etc/pacman.d/mirrorlist.backup >> $m
sed -i 's/^#Server/Server/' $m

rankmirrors -n 10 $m | sudo tee --append /etc/pacman.d/mirrorlist

