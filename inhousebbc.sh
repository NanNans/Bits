#!/bin/sh -x

get_name()
{
local FILENAME="$CLEAN1"
local NEWNAME=""

# check if input matches our criteria
MATCH_EPISODE=$(echo "${FILENAME}" | grep -c "BBC.*[0-9] of [0-9]")
MATCH_DOCUMENTARY=$(echo "${FILENAME}" | grep -c "BBC.*[0-9]\{4\}")
MATCH_SERIES=$(echo "${FILENAME}" | grep -c "BBC\(.*\)\(\(s\|S\)[0-9]*\(e\|E\)[0-9]*\)\(.*\)")

# if it matches then modify
if [ "${MATCH_EPISODE}" = "1" ]; then

NEWNAME=$(echo "${FILENAME}" | sed -e 's/BBC\(.*\)\([0-9]\) of [0-9]\(.*\)/\1 s01e0\2 \3/')

elif [ "${MATCH_DOCUMENTARY}" = "1" ] && [ "${MATCH_SERIES}" = "0" ]; then

NEWNAME=$(echo "${FILENAME}" | sed -e 's/BBC\(.*\)\([0-9]\{4\}\)\(.*\)/BBC documentaries \2x \1 \3/')

elif [ "${MATCH_SERIES}" = "1" ]; then

NEWNAME=$(echo "${FILENAME}" | sed -e 's/BBC\(.*\)\([a-zA-Z][0-9]*[a-zA-Z][0-9]*\)\(.*\)/\1\2/')

fi

# clean up: remove trailing spaces, double spaces, spaces before dot
echo "${NEWNAME}" | sed -e 's/^ *//' -e 's/  / /g' -e 's/ \./\./g'
}

FULL=$1
FN1=$(basename "$1")
DN1=$(dirname "$1")
EXT1="${FN1##*.}"

CLEAN1="${FN1%.*}"

NN1=$(get_name "${CLEAN1}")

mv "$1" "$DN1/${NN1}.${EXT1}"

newfull="$DN1/${NN1}.${EXT1}"
label="4"
osascript -e "tell application \"Finder\" to set label index of alias POSIX file \"$newfull\" to $label"