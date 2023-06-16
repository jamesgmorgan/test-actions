#!/bin/bash -ex

if [[ "$1" == "" ]]; then
    echo "Usage: $0 dry_run[0=disable|1=enable]" >&2
    echo "Usage: $0 0" >&2
    exit 1
fi
dryRun="$1"
[[ $dryRun == "0" ]] && dryRun="" || dryRun="DRY-RUN: "

if [ -z "$ONSHAPE_ADMIN_PAT" ]; then
    echo "Error: ONSHAPE_ADMIN_PAT is unset" >&2
    exit 1
fi

runnerJson="${REPO_BUILD_TOOLS}/buildSrc/tools/config/runners.json"
url='https://api.github.com/orgs/onshape/actions/runners'
nodes=$(curl -s "$url" -X GET -H "Accept: application/vnd.github.v3+json" -H "Authorization: token $ONSHAPE_ADMIN_PAT" \
    | jq -r '.runners[] | select(.status == "offline") | .name' | paste -s -d ' ' -)

for node in $nodes; do
    echo "${dryRun}Restarting: $node" >&2
    runnerIp=$(jq -r --arg NODE "$node" 'to_entries[] | select(.key == $NODE) | .value.ip' $runnerJson)
    [[ $dryRun == "" ]] && ssh -o StrictHostKeyChecking=no -o LogLevel=ERROR jenkins@"$runnerIp" "cd ~/actions-runner; ./svc.sh stop; ./svc.sh start" >&2
done

echo "$nodes"
