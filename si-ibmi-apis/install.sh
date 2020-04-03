#!/bin/sh

FILE=/etc/resolv.conf

if test -f "$FILE"; then
    echo "$FILE exist"
fi
