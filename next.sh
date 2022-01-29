#!/bin/bash

BASEDIR=$(cd "$(dirname "$0")" && pwd)

function new_practice() {
  number=$1
  cat <<EOF
# $number

実行結果

\`\`\`
\`\`\`
EOF
}

function new_problem() {
  number=$1
  cat <<EOF
# $number

## 解答

\`\`\`
\`\`\`

## 考察
EOF
}

files=(
  $(grep '\[ \]' $BASEDIR/README.md \
  | tr : ' ' \
  | awk -F' ' '
      $4 == "練習" { printf("practice/%s.md\n", $5) }
      $4 == "問題" { printf("problem/%03d.md\n", $5) }
    ')
)

for f in ${files[*]}; do
  if [ ! -f $BASEDIR/$f ]; then
    kind=${f%/*}
    number=${f#*/}
    number=${number%.md}
    number=$(echo $number | sed 's/^0*//')
    break
  fi
done    

case "$kind" in
  'practice' )
    new_practice "$number"
    ;;
  'problem' )
    new_problem "$number"
    ;;
esac >$f

echo "Created $kind/$(basename $f)"
