#!/bin/bash

# Log everything
echo "$(date): Script started" >> /tmp/battery_debug.log

# Get battery percentage
BATTERY=$(cat /sys/class/power_supply/BAT0/capacity)
STATUS=$(cat /sys/class/power_supply/BAT0/status)

echo "$(date): Battery: $BATTERY%, Status: $STATUS" >> /tmp/battery_debug.log

# Fix variable names (lowercase vs uppercase)
battery=$BATTERY
status=$STATUS

# Critical low battery warning at 10% with suspend after 30 seconds
if [ "$battery" -le 15 ] && [ "$status" != "Charging" ] && [ "$status" != "charging" ]; then
    echo "$(date): Critical battery level - showing warning with 30s timer" >> /tmp/battery_debug.log
    notify-send -u critical -t 30000 "CRITICAL BATTERY" "Battery at $battery%. System will suspend in 30 seconds!" 2>&1 >> /tmp/battery_debug.log
    
    # Wait 30 seconds then suspend
    sleep 30
    
    # Check if still not charging and still critical after the wait
    STATUS_AFTER_WAIT=$(cat /sys/class/power_supply/BAT0/status)
    if [ "$STATUS_AFTER_WAIT" != "Charging" ] && [ "$STATUS_AFTER_WAIT" != "charging" ]; then
        echo "$(date): Executing suspend command" >> /tmp/battery_debug.log
        systemctl suspend && i3lock -i /home/operator/Pictures/namibia2kpxlD.jpg -t
    else
        echo "$(date): Charging detected during wait period - aborting suspend" >> /tmp/battery_debug.log
        notify-send "Battery Alert" "Charging detected - suspend cancelled"
    fi

# Regular low battery warning at 25%
elif [ "$battery" -le 25 ] && [ "$status" != "Charging" ] && [ "$status" != "charging" ]; then
    echo "$(date): should send notification" >> /tmp/battery_debug.log
    notify-send -u critical "Batt_Low" "$battery%" 2>&1 >> /tmp/battery_debug.log
fi
