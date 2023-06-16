#!/bin/bash -ex

mkdir actions-runner
cd actions-runner
curl -o actions-runner-linux-x64-2.301.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.301.1/actions-runner-linux-x64-2.301.1.tar.gz
tar xzf ./actions-runner-linux-x64-2.301.1.tar.gz
