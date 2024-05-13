#! /bin/bash

echo "$( pwd )"
echo "${BASH_SOURCE[0]}"
echo "$(dirname "${BASH_SOURCE[0]}")"
echo "$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

git diff --exit-code > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "There are uncommitted changes. Please commit or stash them before updating."
    exit 1
fi

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

curl -s https://api.sevdesk.de/openapi.yaml -o external/openapi-updated.yaml

"$SCRIPT_DIR/merge.sh" "external/openapi-updated.yaml"
