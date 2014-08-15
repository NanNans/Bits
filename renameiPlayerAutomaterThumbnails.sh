#!/bin/bash
FN1=$(basename "$1")
DN1=$(dirname "$1")
NEWNAME=$(echo "$FN1" | sed -E 's/-resized-[0-9]*.jpg/.tbn/')

mv "$1" "$DN1"/"$NEWNAME"