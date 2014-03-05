#!/bin/bash

#  existing show.sh
#  
#
#  Created by Hannah Herman on 2.21.2014.
#

shopt -s nocasematch

FN1=$(basename "$1")
CLEAN1="${FN1%.*}"
BEFOREID=$(echo "$CLEAN1" | sed -E 's/([a-zA-Z0-9 \!]*)s[0-9]+e[0-9]+([a-zA-Z0-9 ]*)/\1/' | sed -E 's/[[:punct:]]//g' | sed -E 's/ $//')
echo "$BEFOREID"
FINDLINE=$(grep -c -i "$BEFOREID" ~/Staging\ Area/TempTxts/allShowDirs.txt)
echo "$FINDLINE"
FINDDIR=$(grep -i "$BEFOREID" ~/Staging\ Area/TempTxts/allShowDirs.txt)
echo "$FINDDIR"
COUNTYEARS=$(echo "$CLEAN1" | egrep -c "[0-9]{4}.[0-9]{4}")

if [[ $COUNTYEARS = 0 ]] && [[ $FINDLINE = 1 ]] ; then 
	mv "$1" /Volumes/Storage\ Unit/^Departures
	osascript -e "tell application \"Finder\" to set label index of alias POSIX file \"$1\" to \"6\""
	echo "GoodRun"
else osascript -e "tell application \"Finder\" to set label index of alias POSIX file \"$1\" to \"4\"" 
fi


shopt -u nocasematch