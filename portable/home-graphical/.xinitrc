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

# Paint desktop background.
feh --bg-fill ~/.config/wallpaper.local/* 2> /dev/null

# Start window manager.
case $WM in
  openbox     ) exec openbox-session;;
  i3          ) exec i3;;
  kde         ) exec startplasma-x11;;
  dwm         )
      # Start additional DWM specific programs.
      slstatus &

      # As long as dwm keeps returning success, keep re-running it.
      # This allows "configuration" to be reloaded be recompiling.
      # To actually exit, kill xinit.
      while dwm; do
          false;
      done
      ;;

  # No known session. Try to execute as a command.
  *           ) exec $WM;;
esac
