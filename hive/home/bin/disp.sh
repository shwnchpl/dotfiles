#!/bin/bash

set -e

if [ "$1" = "main" ]; then
    xrandr --output HDMI-0 --primary --mode 1920x1080
    xrandr --output DP-3 --off
elif [ "$1" = "tv" ]; then
    xrandr --output DP-3 --primary --mode 1920x1080
    xrandr --output HDMI-0 --off
elif [ "$1" = "both" ]; then
    xrandr --output HDMI-0 --primary --mode 1920x1080
    xrandr --output DP-3 --mode 1920x1080
else
    echo "usage: $0 [main|tv|both]" 1>&2
    exit 1
fi
