#!/bin/bash

threshold=$1
per=$(free | grep Mem | awk '{print $3/$2 * 100}')
if (( $(echo "$per > $threshold" |bc -l) )); then
    echo 'High memory usage alert!'
	echo 'Processes with the most memory usage: '
	echo "$(ps -eocomm,pcpu | egrep -v '(0.0)|(%MEM)' | sort -k2nr | head -10)"
fi
