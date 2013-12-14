#!/bin/sh -x

get_name()
{
    local FILENAME="$FN1"
    local NEWNAME=""
        
    # check if input matches our criteria
    MATCH_EPISODE=$(echo "${FILENAME}" | grep -c "BBC.*[0-9] of [0-9]")
    MATCH_DOCUMENTARY=$(echo "${FILENAME}" | grep -c "BBC.*[0-9]\{4\}")
                    
    # if it matches then modify
    if [ "${MATCH_EPISODE}" = "1" ]; then
                            
        NEWNAME=$(echo "${FILENAME}" | sed -e 's/BBC\(.*\)\([0-9]\) of [0-9]\(.*\)/\1 s01e0\2 \3/')
                                    
    elif [ "${MATCH_DOCUMENTARY}" = "1" ]; then
                                        
        NEWNAME=$(echo "${FILENAME}" | sed -e 's/BBC\(.*\)\([0-9]\{4\}\)\(.*\)/BBC documentaries \2x \1 \3/')
                                                
    fi
                                                    
    # clean up: remove trailing spaces, double spaces, spaces before dot
    echo "${NEWNAME}" | sed -e 's/^ *//' -e 's/  / /g' -e 's/ \./\./g'
}
                                                            
FN1=$3
#FN2=""
#FN3=""
                                                            
NN1=$(get_name "${FN1}")
#NN2=$(get_name "${FN2}")
#NN3=$(get_name "${FN3}")
     
avi=$/volume1/Storage\ Unit/^Complete/"${FN1}.avi"
mp4=$/volume1/Storage\ Unit/^Complete/"${FN1}.mp4"
mkv=$/volume1/Storage\ Unit/^Complete/"${FN1}.mkv"

1=$(/volume1/Storage\ Unit/^Departures/"${NN1}.avi")
2=$(NN1)

mv /volume1/Storage\ Unit/^Complete/"${FN1}.avi" /volume1/Storage\ Unit/^Departures/"${NN1}.avi"
#!/usr/bin/env python autoProcessTV.py()
echo "${FN1} -> ${NN1} plus python"









                                                            
#echo "${FN1} -> ${NN1} and $@"
#echo "${FN2} -> ${NN2}"
#echo "${FN3} -> ${NN3}"
