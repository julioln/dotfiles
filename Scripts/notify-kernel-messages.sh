#!/bin/bash

journalctl -k -f | while read line; do 
	title=$(echo "$line" | cut -d ' ' -f 5)
	content=$(echo "$line" | cut -d ' ' -f 6-)
	notify-send -u low "$title" "$content" 
done

