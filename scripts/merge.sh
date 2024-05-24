#! /bin/bash

git diff --exit-code > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "There are uncommitted changes. Please commit or stash them before merging."
    exit 1
fi

MERGE_FILE="$1"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

npx --yes patch-utils > /dev/null 2>&1

npx patch-utils sort-yaml openapi.yaml -t "$MERGE_FILE" -o > /dev/null
npx patch-utils sort-yaml external/openapi.yaml -t "$MERGE_FILE" -o > /dev/null

git diff --exit-code > /dev/null 2>&1
if [ $? -ne 0 ]; then
    git add openapi.yaml external/openapi.yaml
    git commit -m "refactor: Sort for update"
fi

npx patch-utils sort-yaml openapi.yaml "openapi.yaml~" > /dev/null
npx patch-utils sort-yaml external/openapi.yaml "external/openapi.yaml~" > /dev/null
npx patch-utils sort-yaml "$MERGE_FILE" "$MERGE_FILE~" > /dev/null

git merge-file -p --zdiff3 -L "openapi.yaml" -L "previous external/openapi.yaml" -L "external/openapi.yaml" "openapi.yaml~" "external/openapi.yaml~" "$MERGE_FILE~" > openapi.yaml
status=$?

mv "$MERGE_FILE" external/openapi.yaml

rm "external/openapi.yaml~"
rm "$MERGE_FILE~"
rm "openapi.yaml~"

if [ $status -ne 0 ]; then
    git add external/openapi.yaml

    echo ""
    echo "Conflicts detected! Please"
    echo "1. resolve them,"
    echo "2. sort the file,"
    echo -e "\t\033[1mnpx patch-utils sort-yaml openapi.yaml -t \"external/openapi.yaml\" -o\033[0m"
    echo "3. commit manually."
    echo -e "\t\033[1m git add openapi.yaml && git commit -m \"build(external)\\: Update openapi.yaml\" \033[0m"

    if [ -z ${CI+x} ]; then
        code openapi.yaml
    fi

    exit 1
fi

npx patch-utils sort-yaml openapi.yaml -t "external/openapi.yaml" -o > /dev/null

git diff --exit-code > /dev/null 2>&1
if [ $? -ne 0 ]; then
    git add openapi.yaml external/openapi.yaml
    git commit -m "build(external): Update openapi.yaml"
    echo ""
    echo "Merge finished."
else
    echo ""
    echo "Merge finished with no changes."
fi
