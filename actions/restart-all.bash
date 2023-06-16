#!/bin/bash -e

if [[ "$1" == "" ]]; then
    echo "Usage: $0 dry_run[0=disable|1=enable]"
    echo "Usage: $0 0"
    exit 1
fi
dryRun="$1"

[[ $dryRun == "0" ]] && dryRun=""

nodes=($(jq -r 'to_entries[] | "\(.key)"' runners.json))
ips=($(jq -r 'to_entries[] | "\(.value | .ip)"' runners.json))
for i in "${!nodes[@]}"; do
    echo "${nodes[$i]}"
    ./restart.bash ${ips[$i]} $dryRun
done
