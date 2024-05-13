#! /bin/sh

git diff --exit-code > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "There are uncommitted changes. Please commit or stash them before merging."
    exit 1
fi

MergeFile="$1"
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

yarn dlx patch-utils sort-yaml openapi.yaml -t "$MergeFile" -o > /dev/null
yarn dlx patch-utils sort-yaml external/openapi.yaml -t "$MergeFile" -o > /dev/null

git diff --exit-code > /dev/null 2>&1
if [ $? -ne 0 ]; then
    git add openapi.yaml external/openapi.yaml
    git commit -m "refactor!: Sort for update"
fi

yarn dlx patch-utils sort-yaml openapi.yaml "openapi.yaml~" > /dev/null
yarn dlx patch-utils sort-yaml external/openapi.yaml "external/openapi.yaml~" > /dev/null
yarn dlx patch-utils sort-yaml "$MergeFile" "$MergeFile~" > /dev/null

git merge-file -p --zdiff3 -L "openapi.yaml" -L "previous external/openapi.yaml" -L "external/openapi.yaml" "openapi.yaml~" "external/openapi.yaml~" "$MergeFile~" > openapi.yaml
status=$?

mv "$MergeFile" external/openapi.yaml

rm "external/openapi.yaml~"
rm "$MergeFile~"
rm "openapi.yaml~"

if [ $status -ne 0 ]; then
    git add external/openapi.yaml

    echo ""
    echo "Conflicts detected! Please"
    echo "1. resolve them,"
    echo "2. sort the file,"
    echo "\t\033[1myarn dlx patch-utils sort-yaml openapi.yaml -t \"external/openapi.yaml\" -o\033[0m"
    echo "3. commit manually."
    echo "\t\033[1m git add openapi.yaml && git commit -m \"build(external)\\!: Update openapi.yaml\" \033[0m"

    code openapi.yaml

    exit 1
fi

yarn dlx patch-utils sort-yaml openapi.yaml -t "external/openapi.yaml" -o > /dev/null

git diff --exit-code > /dev/null 2>&1
if [ $? -ne 0 ]; then
    git add openapi.yaml external/openapi.yaml
    git commit -m "build(external)!: Update openapi.yaml"
    echo ""
    echo "Merge finished."
else
    echo ""
    echo "Merge finished with no changes."
fi
