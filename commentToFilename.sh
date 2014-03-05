#!/bin/sh

#  comment.sh
#  
#
#  Created by Hannah Herman on 1.28.2014.
#
FULL=$1
COMMENT=$(exiftool -S -comment "$FULL")
DISK=$(exiftool -S -disknumber "$FULL")
TRACK=$(exiftool -S -tracknumber "$FULL")

get_cmnt()
{
local LONG="$COMMENT"
local EDIT=""

EDIT=$(echo "${LONG}" | sed -E 's/(.+)(With |with )(.+,.+,[^\.]*)(.*)/\3/')

echo "${EDIT}"
}

get_disk()
{
local FIRST="$DISK"
local FOUND=""

FIND=$(echo "${DISK}" | sed -E 's/(.+\: )([0-9]*)( of).*/\2/')

echo "${FIND}"
}

get_track()
{
local FIRST="$TRACK"
local FOUND=""

FIND=$(echo "${TRACK}" | sed -E 's/(.+\: )([0-9]*)( of).*/\2/')

echo "${FIND}"
}

FN1=$(basename "$1")
DN1=$(dirname "$1")
EXT1="${FN1##*.}"

NEWCOMMENT=$(get_cmnt "$COMMENT")
NEWDISK=$(get_disk "$COMMENT")
NEWTRACK=$(get_track "$COMMENT")
FINALNAME=$(echo "$NEWDISK"-0"$NEWTRACK" "$NEWTRACK". "$NEWCOMMENT")
TRUSTITUNESFINAL=$(echo "$NEWTRACK". "$NEWCOMMENT")


#mv "$1" "$DN1/${FINALNAME}.${EXT1}"

echo "$TRUSTITUNESFINAL"

