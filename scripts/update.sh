#! /bin/bash

git diff --exit-code > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "There are uncommitted changes. Please commit or stash them before updating."
    exit 1
fi

parent_path=$( cd $(dirname "$0") ; pwd -P )

curl -s https://api.sevdesk.de/openapi.yaml -o external/openapi-updated.yaml

"$parent_path/merge.sh" "external/openapi-updated.yaml"
