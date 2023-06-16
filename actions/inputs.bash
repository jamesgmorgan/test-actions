#!/bin/bash -ex
cat << 'EOF' | jq -r 'to_entries[] | "\(.key): \(.value)"'
$1
EOF
