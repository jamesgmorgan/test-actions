#!/bin/bash -e

if [[ "$1" == "" ]]; then
    echo "Usage: $0 runner_node_ip_address"
    exit 1
fi
runnerIp="$1"
dryRun="$2"

[[ $dryRun != "" ]] && dryRun="DRY-RUN: "

runnerProc=$(ssh -o StrictHostKeyChecking=no -o LogLevel=ERROR jenkins@"$runnerIp" "ps -ef | grep Runner.Listener | grep -v grep") || true
if [[ "$runnerProc" == "" ]]; then
    [[ $dryRun == "" ]] && ssh -o StrictHostKeyChecking=no -o LogLevel=ERROR jenkins@"$runnerIp" "cd ~/actions-runner; ./svc.sh stop; ./svc.sh start"
    echo "${dryRun}Runner restarted"
fi
