#!/bin/sh -x

get_name()
{
local FILENAME="$FN1"
local NEWNAME=""

# check if input matches our criteria
MATCH_EPISODE=$(echo "${FILENAME}" | grep -c "BBC.*[0-9]+ of [0-9]+")
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

FN1=$3

NN1=$(get_name "${FN1}")

if [ -f /volume1/Storage\ Unit/^Complete/"${FN1}.avi" ]
then
mv /volume1/Storage\ Unit/^Complete/"${FN1}.avi" /volume1/Storage\ Unit/^Departures/"${NN1}.avi"
echo "${FN1} -> ${NN1} (Complete->Departures)"
elif [ -f /volume1/Storage\ Unit/^Departures/"${FN1}.avi" ]
then
mv /volume1/Storage\ Unit/^Departures/"${FN1}.avi" /volume1/Storage\ Unit/^Departures/"${NN1}.avi"
echo "${FN1} -> ${NN1} (Departures->Departures)"
elif [ -f /volume1/Storage\ Unit/^Complete/TooDamnHigh/"${FN1}.avi" ]
then
mv /volume1/Storage\ Unit/^Complete/TooDamnHigh/"${FN1}.avi" /volume1/Storage\ Unit/^Complete/TooDamnHigh/Watched/"${NN1}.avi"
echo "TooDamnHigh <3 BBC ${FN1} -> ${NN1} (TooDamnHigh->Watched)"
else
echo "Where is this? I only try Complete, Departures, and TooDamnHigh."
fi



#echo "${FN1} -> ${NN1} and $@"