#!/bin/bash

n=${1:-1000}

w=( $(curl https://www.mit.edu/~ecprice/wordlist.10000 2>/dev/null) )
d=( $(curl https://publicsuffix.org/list/public_suffix_list.dat 2>/dev/null | grep '^[0-9a-z]') )

wlen=${#w[@]}
dlen=${#d[@]}
for i in $(seq $n); do
  [[ $((RANDOM % 2)) -eq 1 ]] \
  && echo ${w[$((RANDOM % wlen))]}.${w[$((RANDOM % wlen))]}.${d[$((RANDOM % dlen))]} \
  || echo ${w[$((RANDOM % wlen))]}.${d[$((RANDOM % dlen))]}
done
