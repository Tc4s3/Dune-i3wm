#!/bin/bash
n=("0;30" "0;31" "0;32" "0;33" "0;34" "0;35" "0;36" "0;37")  # Normal
b=("1;30" "1;31" "1;32" "1;33" "1;34" "1;35" "1;36" "1;37")  # Bright/Faint
for c in "${n[@]}"; do printf "\e[${c}m▆▆▆▆▆\e[0m"; done; printf "\n"
for c in "${b[@]}"; do printf "\e[${c}m▆▆▆▆▆\e[0m"; done; printf "\n"
