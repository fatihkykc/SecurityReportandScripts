#!/bin/bash

rootUsage=($(df -k /))

if [[ ! -f usedDisk ]]; then
    echo ${rootUsage[10]} >> usedDisk
else
    old=`tail -1 usedDisk`
    if [ ${old} -gt ${rootUsage[10]} ]; then
        echo 'Disk space has decreased since the last run.'
    fi
fi
echo ${rootUsage[10]} >> usedDisk
