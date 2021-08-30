#!/bin/sh

WM=${CUSTOM_X_WM:-dwm}

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -f ~/.xprofile ]; then
    . ~/.xprofile
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Autostart some nice programs.
feh --bg-fil ~/.config/wallpaper/pixel_tokyo.png &
~/bin/stable-notification-daemon.sh &
ibus-daemon -rdx

# Start window manager.
case $WM in
  openbox     ) exec openbox-session;;
  i3          ) exec i3;;
  kde         ) exec startplasma-x11;;
  dwm         ) while dwm; do false; done;;

  # No known session. Try to execute as a command.
  *           ) exec $WM;;
esac
