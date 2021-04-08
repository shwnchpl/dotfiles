#!/bin/bash

# Quick and dirty. There is almost certainly a better way
# to do this, but for my purposes this works fine.

spotifyd --no-daemon &> /dev/null &
daemon_pid=$!
spt
kill -TERM $daemon_pid
