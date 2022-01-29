#!/bin/bash

if [ $# -ge 1 ]; then
  number=$1
else
  read number
fi

echo $(($number * 2))
