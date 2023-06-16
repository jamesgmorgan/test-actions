#!/bin/bash -e

#comment3

if [[ "$1" == "" ]]; then
    echo "Error, missing param"
    exit 1
fi

echo "Total $1"
for ((i = 0 ; i < $1 ; i++)); do
    echo "$i"
    sleep 1
done
