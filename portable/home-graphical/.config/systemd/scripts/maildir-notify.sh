#!/bin/bash

mkdir -p ~/.cache
test -f ~/.cache/.maildir-last-notify ||
    touch -d@1 ~/.cache/.maildir-last-notify

for account in $(ls ~/mail); do
    newcount=$(\
        find ~/mail/$account/*/new -type f          \
            -newer ~/.cache/.maildir-last-notify    \
            2> /dev/null                            \
            | wc -l)
    if [ "$newcount" -gt "0" ]; then
        notify-send "New Mail" "$newcount new messages for $account"
    fi
done

touch ~/.cache/.maildir-last-notify
