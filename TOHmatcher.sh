#!/bin/bash

#  TOHmatcher.sh
#  
#
#  Created by Hannah Herman on 2.27.2014.
#
shopt -s nocasematch

FN1=$(basename "$1")
CLEAN1="${FN1%.*}"

EPNUM=$(echo "$CLEAN1" | sed -E 's/Ep\. ([0-9]+)[^0-9].*/\1/')


EXISTDIRMATCH=$(ls -d /Volumes/Storage\ Unit/^Departures/*/ | egrep -c -i -e "This Old House")
echo "$EXISTDIRMATCH"
if [[ $EXISTDIRMATCH = 1 ]] ; then

	for dir in /Volumes/Storage\ Unit/^Departures/*/
	do
	FNDIR=$(basename "$dir")
	if [[ $FNDIR =~ "This Old House" ]] ; then
		#osascript -e "tell application \"Finder\" to set label index of alias POSIX file \"$1\" to \"2\""
		#mv "$1" "$dir"
		#osascript -e "tell application \"Finder\" to set label index of alias POSIX file \"$1\" to \"6\""
		#wait 20
		#osascript -e "tell application \"Finder\" to set label index of alias POSIX file \"$dir\" to \"6\""
		echo "GoodRun"
	fi
	done
else
	osascript -e "tell application \"Finder\" to set label index of alias POSIX file \"$1\" to \"1\""

shopt -u nocasematch