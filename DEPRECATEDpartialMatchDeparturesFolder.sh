#!/bin/bash

#  partial match.sh
#  
#
#  Created by Hannah Herman on 2.21.2014.
#
shopt -s nocasematch

FN1=$(basename "$1")
CLEAN1="${FN1%.*}"
BEFOREID=$(echo "$CLEAN1" | sed -E 's/([[:alnum:][:punct:] ]*)s[0-9]+e[0-9]+.*/\1/' | sed -E 's/[[:punct:]]//g')
AFTERID=$(echo "$CLEAN1" | sed -E 's/.*s[0-9][0-9]+e[0-9][0-9]+([[:alnum:][:punct:] ]+)/\1/' | sed -E 's/[[:punct:]]//g' | sed -E 's/[0-9][0-9][0-9][0-9] *$//' | sed -E 's/ $//')
AFTERGUESS=$(echo "$CLEAN1" | sed -E 's/.*[0-9][0-9][0-9][0-9]x[0-9]* (.*[[:alnum:][:punct:]])  +/\1/' | sed -E 's/[[:punct:]]//g' | sed -E 's/ $//')
echo "$BEFOREID"
echo "$AFTERID"
echo "$AFTERGUESS"

for dir in ls -maxdepth 1 /Volumes/Storage\ Unit/^Departures/*/
do
FNDIR=$(basename "$dir")
FOLDERQUERIED=$(echo "$FNDIR" | sed -E 's/(.*)\- [0-9]*x[0-9]* - (.*)/\1 \2/' | sed -E 's/[[:punct:]]//g')
echo "$FOLDERQUERIED"
if [[ $FOLDERQUERIED =~ $AFTERID ]] || [[ $FOLDERQUERIED =~ $AFTERGUESS ]] ; then
	#osascript -e "tell application \"Finder\" to set label index of alias POSIX file \"$1\" to \"2\""
	#mv "$1" "$dir"
	#osascript -e "tell application \"Finder\" to set label index of alias POSIX file \"$1\" to \"6\""
	echo "GoodRun"
else
	osascript -e "tell application \"Finder\" to set label index of alias POSIX file \"$1\" to \"1\""
fi
done

shopt -u nocasematch