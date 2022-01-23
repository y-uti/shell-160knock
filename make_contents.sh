#!/bin/bash

BASEDIR=$(cd "$(dirname "$0")" && pwd)

cat shellgei160/qdata/contents.md \
| sed '/^ *$/d' \
| sed '/.tex$/d' \
| sed 's/ 出題.*//' \
| sed 's/^.*問題[0-9]* //' \
| sed 's/^.級/問題/' \
| awk 'BEGIN { n = 1 }
       $1 == "問題" { sub("問題 ", "", $0); printf("問題 %d: %s\n", n, $0); n++; next; }
       { print $0 }' \
| awk 'BEGIN { p = 0; c = 0; }
       $0 ~ "^%" { next }
       $1 == "#" && p == 0 { print $0; p++; next; }
       $1 == "#" && p >= 1 { gsub("# [0-9]. ", "", $0); printf("# 第 %d 部 %s\n", p, $0); p++; next; }
       $1 == "##" { c++; s = 0; gsub("## [0-9]. ", "", $0); printf("## 第 %d 章 %s\n", c, $0); next; }
       $1 == "###" { s++; i = 1; sub("### ", "", $0); printf("### %d.%d %s\n", c, s, $0); next; }
       $1 == "練習" { sub("練習 ", "", $0); printf("練習 %d.%d.%c: %s\n", c, s, i + 96, $0); i++; next; }
       { print $0 }' \
| awk '$1 !~ "^#" { printf("- [ ] %s\n", $0); next; }
       { print $0 }' \
| awk '$1 == "#" { next }
       { print $0 }' \
| awk 'BEGIN { cnt = 1 }
       $1 ~ "^#" { printf("%s%s\n\n", cnt == 0 ? "\n" : "", $0); cnt = 1; next; }
       { print $0; cnt = 0; }'
