#!/bin/bash

for f in _*.wav; do 
	inf_file=$(echo $f | sed 's/\.wav$/.inf/g')
	title=$(sed 's/=\s\+/=/g' $inf_file | grep Tracktitle | cut -d = -f 2 | tr -d "'" | sed 's/^\.\+\s\+//g')
	number=$(sed 's/=\s\+/=/g' $inf_file | grep Tracknumber | cut -d = -f 2)
	number_padded=$(printf "%02d" $number)

	echo "Converting $f to $number_padded - $title.flac"
	flac $f -o "$number_padded - $title.flac" &
done

wait

echo "Done"
