#!/bin/bash

# XXX: This is a minor hack and wouldn't work so well on a system with
# more than one graphical user, but on such a system we probably would
# be running elogind or something else and letting that manage our
# screen locking via xss-lock and xset s anyhow.
sudo -u schapla slock &

sleep 2
