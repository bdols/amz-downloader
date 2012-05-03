#!/bin/bash

PARALLEL=0
if [ $# -eq 0 ] ; then
    echo Usage: $0 [-p] ".amz file"
    echo  -p   Download in parallel
    exit 1
else
    ARG=$1
    if [ $ARG == "-p" ] ; then
        PARALLEL=1
        shift
        ARG=$1
    fi
fi
echo $ARG

which wget > /dev/null
if [ $? -ne 0 ]; then
    echo Please install wget.
    exit 1
fi
for i in `grep location $ARG | sed 's/.*<location>//' | sed 's/<\/location.*//'`; do
    if [ $PARALLEL -eq 1 ] ; then
        wget "$i" &
    else
        wget "$i"
    fi
done



