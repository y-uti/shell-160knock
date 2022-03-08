#!/bin/bash

BASEDIR=$(cd "$(dirname "$0")" && pwd)

# hira to kana
(
  for i in $(seq 0xe38181 0xe3819f); do printf "s/%06x/%06x/g\n" $i $((i - 0xe38180 + 0xe382a0)); done
  for i in $(seq 0xe381a0 0xe381bf); do printf "s/%06x/%06x/g\n" $i $((i - 0xe381a0 + 0xe38380)); done
  for i in $(seq 0xe38280 0xe38296); do printf "s/%06x/%06x/g\n" $i $((i - 0xe38280 + 0xe383a0)); done
) >$BASEDIR/hira_kata.sed

# kata to hira
(
  for i in $(seq 0xe382a1 0xe382bf); do printf "s/%06x/%06x/g\n" $i $((i - 0xe382a0 + 0xe38180)); done
  for i in $(seq 0xe38380 0xe3839f); do printf "s/%06x/%06x/g\n" $i $((i - 0xe38380 + 0xe381a0)); done
  for i in $(seq 0xe383a0 0xe383b6); do printf "s/%06x/%06x/g\n" $i $((i - 0xe383a0 + 0xe38280)); done
) >$BASEDIR/kata_hira.sed

# kata to hankaku
(
  for i in $(seq 0xe382a1 2 0xe382a9); do printf "s/%06x/%06x/g\n" $i $(((i - 0xe382a1) / 2 + 0xefbda7)); done # ァ - ォ
  for i in $(seq 0xe382a2 2 0xe382aa); do printf "s/%06x/%06x/g\n" $i $(((i - 0xe382a2) / 2 + 0xefbdb1)); done # ア - オ
  for i in $(seq 0xe382ab 2 0xe382bd); do printf "s/%06x/%06x/g\n" $i $(((i - 0xe382ab) / 2 + 0xefbdb6)); done # カ - ソ
  for i in $(seq 0xe382ac 2 0xe382be); do printf "s/%06x/%06xefbe9e/g\n" $i $(((i - 0xe382ac) / 2 + 0xefbdb6)); done # ガ - ゾ
  echo "s/e382bf/efbe80/g" # タ
  echo "s/e38380/efbe80efbe9e/g" # ダ
  echo "s/e38381/efbe81/g" # チ
  echo "s/e38382/efbe81efbe9e/g" # ヂ
  echo "s/e38383/efbdaf/g" # ッ  
  for i in $(seq 0xe38384 2 0xe38388); do printf "s/%06x/%06x/g\n" $i $(((i - 0xe38384) / 2 + 0xefbe82)); done # ツ - ト
  for i in $(seq 0xe38385 2 0xe38389); do printf "s/%06x/%06xefbe9e/g\n" $i $(((i - 0xe38385) / 2 + 0xefbe82)); done # ヅ - ド
  for i in $(seq 0xe3838a 0xe3838e); do printf "s/%06x/%06x/g\n" $i $((i - 0xe3838a + 0xefbe85)); done # ナ - ノ
  for i in $(seq 0xe3838f 3 0xe3839b); do printf "s/%06x/%06x/g\n" $i $(((i - 0xe3838f) / 3 + 0xefbe8a)); done # ハ - ホ
  for i in $(seq 0xe38390 3 0xe3839c); do printf "s/%06x/%06xefbe9e/g\n" $i $(((i - 0xe38390) / 3 + 0xefbe8a)); done # バ - ボ
  for i in $(seq 0xe38391 3 0xe3839d); do printf "s/%06x/%06xefbe9f/g\n" $i $(((i - 0xe38391) / 3 + 0xefbe8a)); done # パ - ポ
  for i in $(seq 0xe3839e 0xe383a2); do printf "s/%06x/%06x/g\n" $i $((i - 0xe3839e + 0xefbe8f)); done # マ - モ
  for i in $(seq 0xe383a3 2 0xe383a7); do printf "s/%06x/%06x/g\n" $i $(((i - 0xe383a3) / 2 + 0xefbdac)); done # ャ - ョ
  for i in $(seq 0xe383a4 2 0xe383a8); do printf "s/%06x/%06x/g\n" $i $(((i - 0xe383a4) / 2 + 0xefbe94)); done # ャ - ョ
  for i in $(seq 0xe383a9 0xe383ad); do printf "s/%06x/%06x/g\n" $i $((i - 0xe383a9 + 0xefbe97)); done # ラ - ロ
  echo "s/e383af/efbe9c/g" # ワ
  echo "s/e383b2/efbda6/g" # ヲ
  echo "s/e383b3/efbe9d/g" # ン
) >$BASEDIR/kata_hankaku.sed
