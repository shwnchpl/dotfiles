#!/bin/bash

# Loosely based on https://serverfault.com/a/532600.
# Accepts input of the form hh:mm:ss. Hours and minutes may both be
# omitted.

countdown() {
    s=$((${1} + 60*${2} + 60*60*${3}))

    while [ $s -gt 0 ]; do
        HOUR=$((${s}/60/60))
        MIN=$((${s}/60%60))
        SEC=$((${s}%60))

        printf "%02d:%02d:%02d\033[0K\r" $HOUR $MIN $SEC
        sleep 1
        s=$((s-1))
    done
}

# Split input into an array (ss mm hh).
t=$(echo $1 | tr ':' '\n' | tac)

countdown ${t[0]:-0} ${t[1]:-0} ${t[2]:-0}
