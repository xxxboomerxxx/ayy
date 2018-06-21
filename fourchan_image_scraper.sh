#!/bin/bash

if [[ -z "$1" ]]; then
    echo "You must specify a 4chan thread.";
    exit 1;
fi

`curl -s "$1" | grep -Eo '<a class="fileThumb" href="//[0-9a-zA-Z]+\.4chan.org/[a-zA-Z0-9]+/[0-9]+\.[a-zA-Z0-9]+" target' | sed 's/^.*href..\(.*\)..target.*$/https:\1/g' | xargs -n 1 -P 16 wget -qnc`
