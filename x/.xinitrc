#!/bin/sh

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

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# VM graphics drivers are real poop
xrandr --newmode "1920x1080_60.00"  173.00 1920 2048 2248 2567  1080 1083 1088 1120 -hsync +vsync
xrandr --addmode Virtual1 1920x1080_60.00
xrandr --output Virtual1 --mode 1920x1080_60.00

# For testing an approximately 13" screen
xrandr --newmode "1600x900_60.00" 118.25 1600 1696 1856 2012 900 903 908 934 -hsync +vsync
xrandr --addmode Virtual1 1600x900_60.00

compton -b &
~/.fehbg &
syndaemon -i 0.5 -K -R -d
setxkbmap -layout us,il -option grp:alt_shift_toggle,caps:escape
xinput --set-prop "SynPS/2 Synaptics TouchPad" "Device Accel Constant Deceleration" 1.7

exec i3 --shmlog-size=26214400
