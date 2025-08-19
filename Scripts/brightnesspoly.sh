#!/bin/bash

# Get brightness for built-in display (eDP-1) using AMD GPU backlight control
brightness=$(brightnessctl --device='amdgpu_bl1' get 2>/dev/null)
max_brightness=$(brightnessctl --device='amdgpu_bl1' max 2>/dev/null)

# Calculate percentage or show error if device not found
if [[ -z "$brightness" || -z "$max_brightness" ]]; then
    echo "󰃞 (device error)"
    exit 1
fi

percent=$(( (brightness * 100) / max_brightness ))
echo "B: ${percent}"
