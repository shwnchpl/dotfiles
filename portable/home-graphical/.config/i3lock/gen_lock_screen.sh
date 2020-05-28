#!/bin/bash

sleep 5
scrot /tmp/screen.png
convert /tmp/screen.png -filter Gaussian -blur 0x8 $1
rm /tmp/screen.png
