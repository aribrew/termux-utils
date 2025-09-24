#!/bin/bash

CPU_INFO=$(cat /proc/cpuinfo)

VENDOR_ID=$(echo "$CPU_INFO" | grep -m 1 "vendor_id")

if [[ "$VENDOR_ID" == "" ]];
then
    HARDWARE=$(echo "$CPU_INFO" | grep -m 1 "Hardware")

    if [[ "$HARDWARE" == "" ]];
    then
        echo "UNKNOWN"
    else
        VENDOR=$(echo "$HARDWARE" | grep -m 1 "Hardware" | xargs)
        VENDOR=$(echo "$VENDOR" | cut -d ':' -f 2 | xargs)
        
        if [[ $VENDOR == MT* ]];
        then
            echo "Mediatek"
        else
            echo "$VENDOR"
        fi
    fi
else
    VENDOR=$(echo "$VENDOR_ID" | grep -m 1 vendor_id | xargs)
    VENDOR=$(echo "$VENDOR" | cut -d ':' -f 1 | xargs)

    echo "$VENDOR"
fi
