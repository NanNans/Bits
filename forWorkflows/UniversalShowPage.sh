#!/bin/bash

#initial text-parsers:

echo "$1" | sed -E 's/[^[:alnum:][:punct:] ]//g' #get rid of weird characters

echo "$@" #put everything onto one line

echo "$1" | sed -E 's/^([0-9])([^0-9])/0\1 \2/' | sed -E 's/(.)$/\1 /' #put 0 in front of single digits and insert trailing space, so it can be correctly distinguished later from name of Safari window
#result of above is set as variable "fullstring"

echo "$1" | sed -E 's/[0-9]+(.+)/\1/' | sed -E 's/([[:alnum:][:punct:]]) $/\1/' | sed -E 's/^ (.+)/\1/' #cuts down to only stuff after digit to extract ep name, then gets rid of trailing space, then gets rid of leading space
#result of above is sent to file tempsearchstring.txt

#returning to "fullstring" and passing it to:
#run applescript -getShowName, returns "fullstring name of Safari window" as one argument
{SHOWTITLE=$(echo "$1" | sed -E 's/(.*) SickRage.*- (.*)/\2 OOGABOOGA\1/')

echo "${SHOWTITLE}"} #extracts show name from Safari window as everything after last -, then inserts OOGABOOGA to tag the ep number and ep name.
#above is set as variable "showName"

#run applescript -getSourceCode, returns source code of safari tab. Then passes to stdin and:
grep -B 100 -U -f /Users/hannahherman/Staging\ Area/TempTxts/tempsearchstring.txt | grep -U 'tr class' | tail -n 1 | sed -E 's/.+season-([0-9]+).*/\1/' #searches the source code in stdin for contents of tempsearchstring, and returns the 100 preceding lines. The -U was important (forces it to search binary files). Next, extracts relevant 'tr class' line (which contains season info) from the 100 found before. Because we found 100 lines (used to just be 25 but updates kept changing how far back we need to search), there may be multiple 'tr class' lines found, so we use tail -n 1 to find the last one, which will be the one closest to the search string and therefore the right one. Finally, extracts season number (whether year format or just count)
#result of above is set as variable "seasonNumber"
#returning to "showName"
#both are passed as arg1 and arg2 to -finalCompiler
#play Pop sound. Phew!

