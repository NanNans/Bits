#!/bin/sh

#  audiobookify.sh
#  
#
#  Created by Hannah Herman on 1.28.2014.
#
FULL=$1
FN1=$(basename "$1")
DN1=$(dirname "$1")
EXT1="${FN1##*.}"

get_dir()
{
local RUNFILE="$FULL"
local DIRONLY=""

DIRONLY=$(echo "$RUNFILE" | sed -E 's/(.*\/)(.*)(\/.*\..*)/\2/')
echo "$DIRONLY"
}

CLEANDIR=$(get_dir "${FULL}")

if [ -f /Volumes/Storage\ Unit/Audio/Audiobooks/"${CLEANDIR}" ]
then
mv "$1" "/Volumes/Storage Unit/Audio/Audiobooks/${CLEANDIR}/${FN1}"
else
mkdir /Volumes/Storage\ Unit/Audio/Audiobooks/"${CLEANDIR}"
mv "$1" "/Volumes/Storage Unit/Audio/Audiobooks/${CLEANDIR}/${FN1}"
fi