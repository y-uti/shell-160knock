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
  | awk -F' ' '{ \
      sub("練習","practice",$4);
      sub("問題","problem",$4);
      printf("%s/%s.md\n", $4, $5);
    }')
)

for f in ${files[*]}; do
  if [ ! -f $BASEDIR/$f ]; then
    kind=${f%/*}
    number=${f#*/}
    number=${number%.md}
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

echo "Created $kind/$number.md"
