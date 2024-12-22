#!/bin/bash
set -x
set -o pipefail -e

script_dir=$(readlink -f "$(dirname "$0")")

if [ $1 == "testing" ]
then
    repo=testing
    shift
elif [ $1 == "stable" ]
then
    repo=stable
    shift 
else
    echo "Usage: $0 [testing|stable] <debfiles> ..."
    exit 1
fi
for i in oracular sid bookworm trixie
do
    for y in "$@"
    do
        if [ -f "$y" ]
        then
            reprepro -b "$script_dir/$repo" --ignore=wrongdistribution includedeb $i $y
            sleep 1
        fi
    done
done
