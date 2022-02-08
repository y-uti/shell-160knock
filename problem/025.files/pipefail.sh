#!/bin/bash -e
set -o pipefail
trap 'rm .tmp.top10' EXIT

head <(sort) > .tmp.top10

echo "+++++TOP 10+++++"
cat .tmp.top10
