#!/bin/bash

# XXX: This is a minor hack and wouldn't work so well on a system with
# more than one graphical user, but on such a system we probably would
# be running elogind or something else and letting that manage our
# screen locking via xss-lock and xset s anyhow.
DISPLAY=:0 sudo -u schapla /usr/local/bin/slock &

sleep 2
