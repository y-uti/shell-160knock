#!/bin/bash

echo $((${1:-$(read && echo "$REPLY")} * 2))
