#!/bin/sh

URL='https://clip.0x7359.com/'

if ! [ -t 0 ]; then
  curl -F "file=@-" $URL
elif [ $# -eq 1 ]; then
  curl -F "file=@${1}" $URL
elif [ $# -eq 2 ]; then
  curl -F "file=@${1}" -F "time=${2}" $URL
else
  echo "Usage: clip.0x7359.com <file> [time]"
  echo "If in a pipe, reads from STDIN"
  exit 1
fi

echo
