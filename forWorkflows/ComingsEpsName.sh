#!/bin/bash
#initial text-parser:
#echo "$1" | sed -E 's/([^[:alnum:][:punct:] ])//g' | sed -E 's/\[paused\]/ /' | sed -E 's/Season/ /'

LONG=$1

parse_name()
{
local NAME="$LONG"
local NEW=""
MATCH_COMINGEPS=$(echo "$NAME" | egrep -c -i "[0-9]{2,4}x[0-9]*")
MATCH_TVDB=$(echo "$NAME" | egrep -c -i "[0-9] [0-9][0-9]* :")

if [[ "$MATCH_COMINGEPS" = "1" ]] ; then
	NEW=$(echo "$NAME" | sed -E 's/(.*) ([0-9]{2,4}x[0-9]*)(.*)/\1- \2 - \3/' | sed -E 's/([^ ])-/\1 -/')
elif [[ "$MATCH_TVDB" = "1" ]] ; then
	NEW=$(echo "$NAME" | sed -E 's/([0-9]) ([0-9][0-9]*) :/- \1x\2 -/')
fi
echo "${NEW}" | sed -E 's/   */ /g'
}

FOUND=$(parse_name "${LONG}")

mkdir /Volumes/Storage\ Unit/^Departures/"${FOUND}"