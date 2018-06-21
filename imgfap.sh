#!/bin/bash

if [[ -z "$1" ]]; then
    echo "Run like ""$0"" http://www.imagefap.com/pictures/1234567/Title";
    exit 1;
fi

URL="$1""?view=2";
LIST=`curl -s "$URL" | grep -Eo '<a name="[0-9]+" href="/photo/[0-9]+/[^\"]+">' | sed 's/^.*href=.\(.*\)?pgid.*$/http:\/\/imagefap.com\1/g'`
BUFFER=`echo "$LIST" | xargs -n 1 -P16 wget -qnc -O -`
echo "$BUFFER" | grep -Eo '"contentUrl": "[^\"]+",' | sed 's/^.*\":.\"\(.*\)\",.*$/\1/g' | xargs -n 1 -P 16 wget -qnc
