#!/bin/bash

memthreshold=$1
memper=$(free | grep Mem | awk '{print $3/$2 * 100}')
if (( $(echo "$memper > $memthreshold" |bc -l) )); then
    echo 'High memory usage alert!'
	echo 'Processes with the most memory usage: '
	echo "$(ps -eo pid,comm,%mem --sort=-%mem | head -n 5)"
fi

cputhreshold=$2
cpuper=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage}')
if (( $(echo "$cpuper > $cputhreshold" |bc -l) )); then
    echo 'High cpu usage alert!'
	echo 'Processes with the most cpu usage: '
	echo "$(ps -eo pid,comm,%cpu --sort=-%cpu | head -n 5)"
fi
