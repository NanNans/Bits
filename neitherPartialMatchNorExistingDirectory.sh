#!/bin/bash

#  doesn't pass.sh
#
#
#  Created by Hannah Herman on 2.22.2014.
#

EXIST=$(bash /Users/hannahherman/Coding/GitRepos/Bits/existingShowDirectoryFound.sh "$1")
PART=$(bash /Users/hannahherman/Coding/GitRepos/Bits/partialMatchDeparturesFolder.sh "$1")

#if fails to match an existing show or a waiting Departures directory...
if [[ $EXIST != GoodRun ]] && [[ $PART != GoodRun ]]; then
#tell Hazel it has successfully failed to have another home, so Hazel can do whatever it wants to it
echo "0"
fi