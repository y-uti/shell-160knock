#!/bin/bash

BASEDIR=$(cd "$(dirname "$0")" && pwd)

ls $BASEDIR/practice/*.md \
| xargs -I@ basename @ .md \
| xargs -I@ sed -i "/練習 @:/s/\[ \]/\[x\]/" $BASEDIR/README.md

ls $BASEDIR/problem/*.md \
| xargs -I@ basename @ .md \
| sed 's/^0*//' \
| xargs -I@ sed -i "/問題 @:/s/\[ \]/\[x\]/" $BASEDIR/README.md
