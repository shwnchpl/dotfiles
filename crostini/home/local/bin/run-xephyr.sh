#!/bin/bash

unset XDG_RUNTIME_DIR
Xephyr -br -ac -noreset -screen 2400x1600 -dpi 234 -resizeable \
    -fullscreen -noreset :2 &
DISPLAY=:2

BROWSER=/usr/bin/firefox

sleep 1

# Run xrandr once per second to notify of screen size changes.
while xrandr &> /dev/null; do
    feh --bg-fill ~/.config/wallpaper/bladesofgrass.jpg &
    sleep 1;
done &

xrdb -merge $HOME/.Xresources
slstatus &
dwm

pkill Xephyr
