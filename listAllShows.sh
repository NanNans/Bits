#!/bin/bash

echo " " > /Users/hannahherman/Staging\ Area/TempTxts/allShowDirs.txt
for dir in /Volumes/Storage\ Unit/Television\ Shows/*/
	do
	echo "$dir" >> /Users/hannahherman/Staging\ Area/TempTxts/allShowDirs.txt
	done