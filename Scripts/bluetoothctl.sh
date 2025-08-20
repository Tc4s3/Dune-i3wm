#!/bin/bash

bluetoothctl devices | while read -r _ mac name; do
    if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
        echo "BT: $name"
    fi
done
