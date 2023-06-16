#!/bin/bash -ex

for testVar in ARCHIVE_FILE_SPEC S3_BUCKET; do
    if [[ -z ${!testVar} ]]; then
        echo "Error: $testVar is unset"
        exit 1
    fi
done

regEx="^(staging|test)$"
if [[ ! $S3_BUCKET =~ $regEx ]]; then
    echo "Error: invalid S3_BUCKET value - $S3_BUCKET does not match $regEx"
    exit 1
fi

for artifact in ./artifacts/${ARCHIVE_FILE_SPEC}; do
    aws s3 cp "$artifact" s3://onshape-codebuild-builds-us-west-2/"${S3_BUCKET}"/ &
    pids[${#pids[@]}]=$!
done

# Wait for copies to finish and count errors
errors=0
for pid in "${pids[@]}"; do
    wait $pid || ((++errors))
done

exit "$errors"
