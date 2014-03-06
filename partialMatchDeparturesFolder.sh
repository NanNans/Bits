#!/bin/bash -x

shopt -s nocasematch

FN1=$(basename "$1")
DN1=$(dirname "$1")
CLEANNAME="${FN1%.*}"
#echo "$CLEANNAME"
get_name()
{
#to match Show.s00e00.0000-0000.Episode(.mp4)
MATCH_YEARSEASON=$(echo "$CLEANNAME" | egrep -c -i ".*s[0-9]{2,4}e[0-9]{2,4}.[0-9]{4}.[0-9]{4}.*" )
#to match Episode.s00e00(.mp4)
MATCH_BEFOREONLY=$(echo "$CLEANNAME" | egrep -c -i ".*s[0-9]{2,4}e[0-9]{2,4}$" )
##to match Show/Episode.s00e00.Episode/episodecont(.mp4)
MATCH_BASICFORM=$(echo "$CLEANNAME" | egrep -c -i ".*s[0-9]{2,4}e[0-9]{2,4}.[^0-9].*" )
##to match BBC Documentaries 0000x Episode(.mp4)
MATCH_BBCDOCGUESS=$(echo "$CLEANNAME" | egrep -c -i ".*[0-9]{4}x[0-9]*.*" )

if [ "${MATCH_YEARSEASON}" = "1" ]; then
	NEWNAME=$(echo "$CLEANNAME" | sed -E 's/.*s[0-9]{2,4}e[0-9]{2,4}.[0-9]{4}.[0-9]{4}.(.*)/\1/')
elif [ "${MATCH_BEFOREONLY}" = "1" ] && [ "${MATCH_YEARSEASON}" = "0" ]; then
	NEWNAME=$(echo "$CLEANNAME" | sed -E 's/(.*).s[0-9]{2,4}e[0-9]{2,4}$/\1/')
elif [ "${MATCH_BASICFORM}" = "1" ]; then
	NEWNAME=$(echo "$CLEANNAME" | sed -E 's/.*s[0-9]{2,4}e[0-9]{2,4}.([^0-9])(.*)/\1\2/')
elif [ "${MATCH_BBCDOCGUESS}" = "1" ]; then
	NEWNAME=$(echo "$CLEANNAME" | sed -E 's/.*[0-9]{4}x[0-9]*.(.*)/\1/')
fi

echo "${NEWNAME}" | sed -E 's/[[:punct:]]//g' | sed -E 's/[0-9][0-9][0-9][0-9] *$//' | sed -E 's/^ *//' | sed -E 's/  / /g' | sed -E 's/ \./\./g' | sed -E 's/ *$//'
}

PARSE=$(get_name "$CLEANNAME")
#echo "$PARSE"

EXISTDIRMATCH=$(ls -d /Volumes/Storage\ Unit/^Departures/*/ | egrep -c -i -e "$PARSE")
#echo "$EXISTDIRMATCH"

EXISTSUBS=$(ls "$DN1" | egrep -c -i -e "$CLEANNAME.srt" )
#echo "$EXISTSUBS"

if [[ $EXISTDIRMATCH = 1 ]] ; then
	for dir in /Volumes/Storage\ Unit/^Departures/*/
	do
	FNDIR=$(basename "$dir")
	FOLDERQUERIED=$(echo "$FNDIR" | sed -E 's/(.*)\- [0-9]*x[0-9]* - (.*)/\1 \2/' | sed -E 's/[[:punct:]]//g' | sed -E 's/  / /g')
	#echo "$FOLDERQUERIED"
	if [[ $FOLDERQUERIED =~ $PARSE ]] ; then
		mv "$1" "$dir"
		if [[ $EXISTSUBS = 1 ]] ; then mv "$DN1/$CLEANNAME.srt" "$dir"
		fi
#		wait 20
		osascript -e "tell application \"Finder\" to set label index of alias POSIX file \"$dir\" to \"6\""
		echo "GoodRun"
	fi
	done
else
	osascript -e "tell application \"Finder\" to set label index of alias POSIX file \"$1\" to \"1\""
fi


shopt -u nocasematch