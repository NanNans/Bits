#!/bin/bash

#  existing show.sh
#  
#
#  Created by Hannah Herman on 2.21.2014.
#

shopt -s nocasematch

FN1=$(basename "$1")
CLEAN1="${FN1%.*}"
BEFOREID=$(echo "$CLEAN1" | sed -E 's/([a-zA-Z0-9 \!]*).s[0-9]+e[0-9]+.([a-zA-Z0-9 ]*)/\1/')
COUNTYEARS=$(echo "$CLEAN1" | egrep -c "[0-9]{4}.[0-9]{4}")

if [[ $COUNTYEARS = 0 ]]; then 
	for dir in ls -maxdepth 1 /Volumes/Storage\ Unit/Television\ Shows/*/
	do
	FNDIR=$(basename "$dir")
	if [[ $FNDIR == $BEFOREID ]] ; then
	osascript -e "tell application \"Finder\" to set label index of alias POSIX file \"$1\" to \"2\""
	mv "$1" /Volumes/Storage\ Unit/^Departures/!Go!/
	osascript -e "tell application \"Finder\" to set label index of alias POSIX file \"$1\" to \"6\""
	echo "GoodRun"
	else osascript -e "tell application \"Finder\" to set label index of alias POSIX file \"$1\" to \"4\""
	fi
	done
else osascript -e "tell application \"Finder\" to set label index of alias POSIX file \"$1\" to \"4\""
fi


shopt -u nocasematch