#!/bin/bash -ex
if [[ "$1" == "" ]]; then
    echo "Usage: $0 version"
    echo "   ex: $0 1.139"
    exit 1
fi
version="$1"

testUri="s3://onshape-codebuild-builds-us-west-2/test"
stageUri="s3://onshape-codebuild-builds-us-west-2/stage"

testName=$(aws s3 ls "$testUri/translator-master-${version}" | sort -n | tail -1 | awk '{print $4}')
echo aws s3 cp "$testUri/$testName" "$stageUri/${testName/-master-/-rel-}"

helpName="onshape-web-help-${version}.tgz"
echo aws s3 cp "${testUri}/${helpName}" "${stageUri}/${helpName}"
