#!/bin/bash

BASEDIR=$(cd "$(dirname "$0")" && pwd)

ls $BASEDIR/practice/*.md \
| xargs -I@ basename @ .md \
| xargs -I@ sed -i "/練習 @:/s/\[ \]/\[x\]/" $BASEDIR/README.md

ls $BASEDIR/problem/*.md \
| xargs -I@ basename @ .md \
| sed 's/^0*//' \
| xargs -I@ sed -i "/問題 @:/s/\[ \]/\[x\]/" $BASEDIR/README.md

tempfile=$(mktemp)
awk '
  /\[x\] 練習/ { printf("- [x] [%s](practice/%s.md)\n", substr($0, 7), substr($4, 1, length($4) - 1)); next }
  /\[x\] 問題/ { printf("- [x] [%s](problem/%03d.md)\n", substr($0, 7), $4); next }
  { print $0 }
' $BASEDIR/README.md >>$tempfile \
&& mv $tempfile $BASEDIR/README.md
