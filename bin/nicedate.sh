#!/bin/zsh

# print a date like the following with nice colors
# 2022-06-19T20:50:59Z   2022-06-19T13:50:59-0700

autoload -U colors && colors
d1=$(date -u +%Y-%m-%d)
d2=$(date -u +%H:%M:%S)
d3=$(date +%Y-%m-%d)
d4=$(date +%H:%M:%S)
d5=$(date +%z)

echo -n "$fg[white]$d1$fg[cyan]T$fg[white]$d2$fg[cyan]Z   $fg[white]$d3$fg[cyan]T$fg[white]$d4$fg[cyan]$d5"
