#!/bin/bash

# On a graphical system, before applying any stow packages.

# Create home directory skeleton.
cd $HOME
mkdir -p bin downloads media mnt src tmp

# Clone suckless software.
cd $HOME/src
git clone https://git.suckless.org/dwm
git clone https://git.suckless.org/slock
git clone https://git.suckless.org/slstatus
git clone https://git.suckless.org/st

echo "Bootstrap complete."
