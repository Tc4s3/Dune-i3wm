#!/bin/bash

# Combined uptime/boot time script with state tracking
STATE_FILE="/tmp/polybar_uptime_state"

# Toggle state if clicked
if [[ "$1" == "click" ]]; then
    if [[ -f "$STATE_FILE" ]]; then
        rm "$STATE_FILE"
    else
        touch "$STATE_FILE"
    fi
fi

# Determine what to display
if [[ -f "$STATE_FILE" ]]; then
    # Show boot time
    boot_time=$(uptime -s)
    boot_date=$(date -d "$boot_time" '+%Y%m%d')
    boot_clock=$(date -d "$boot_time" '+%H:%M')
    echo "$boot_date:$boot_clock"
else
    # Show uptime
    uptime_seconds=$(</proc/uptime awk '{print int($1)}')
    days=$((uptime_seconds/86400))
    hours=$(( (uptime_seconds%86400)/3600 ))
    minutes=$(( (uptime_seconds%3600)/60 ))
    printf "%dD:%02dH:%02dM\n" "$days" "$hours" "$minutes"
fi
