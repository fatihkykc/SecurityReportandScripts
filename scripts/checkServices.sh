#!/bin/bash

if [[ ! -f currServices ]]; then
    echo "$servs" > currServices
else
    old="$(cat currServices)"
    servs="$(service --status-all)"
    if [ "$old" != "$servs" ]; then
        echo 'Seems like there is a change in services.'
        diff <(echo "$old") <(echo "$servs")
    fi
fi
