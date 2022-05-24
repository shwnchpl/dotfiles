#!/bin/bash

set -e

if [ "$1" = "main" ]; then
    xrandr --output HDMI-0 -r 60 --primary --mode 1920x1080
    xrandr --output DP-3 --off
elif [ "$1" = "tv" ]; then
    xrandr --output DP-3 --primary --mode 1920x1080
    xrandr --output HDMI-0 --off
elif [ "$1" = "both" ]; then
    xrandr --output HDMI-0 -r 60 --primary --mode 1920x1080
    xrandr --output DP-3 --mode 1920x1080
elif [ "$1" = "dual" ]; then
    xrandr --output DP-3 --mode 1920x1080
    xrandr --output HDMI-0 -r 60 --mode 1920x1080 --primary --right-of DP-3
else
    echo "usage: $0 [main|tv|both]" 1>&2
    exit 1
fi
