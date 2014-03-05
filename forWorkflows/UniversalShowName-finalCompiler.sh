#!/bin/sh
#receives season number as first argument, and show name followed by OOGABOOGA followed by episode number and name as second argument.

LONG=$2
#tags season number with HEYLOOK
SEASONO=$(echo "HEYLOOK${1}")

parse_name()
{
local NAME="$LONG"
local NEW=""

#leaves show name alone, but extracts ep number from OOGABOOGA and ep name, and sets up proper formatting, putting HOLDER in place of season number
NEW=$(echo "$NAME" | sed -E 's/OOGABOOGA([0-9][0-9]*) *(.+)/ - HOLDERx\1 - \2/')
echo "${NEW}"
}

SHOWEP=$(parse_name "${LONG}")
#puts it all together, extracting season number from HEYLOOK and putting in place of HOLDER
WITHSEASON=$(echo "${SHOWEP} ${SEASONO}" | sed -E 's/HOLDER(.+) HEYLOOK([0-9]+)/\2\1/')


mkdir /Volumes/Storage\ Unit/^Departures/"${WITHSEASON}"