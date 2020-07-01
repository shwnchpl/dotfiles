#!/bin/bash

# Very nasty hack to work around the fact that notification-daemon
# randomly stops working. It seems to always work for well over
# an hour, so just restart it every hour and be happy.

while true; do
    echo "(Re-)starting notification daemon..."
    /usr/lib/notification-daemon/notification-daemon &
    last_pid=$!
    sleep 60m
    kill -KILL $last_pid
done
