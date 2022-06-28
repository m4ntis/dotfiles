#!/usr/bin/env bash

sleep 3
xrandr --output eDP1 --left-of HDMI1 --output HDMI1 --mode 2560x1440
~/.fehbg &

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar main &
MONITOR=HDMI1 BARWIDTH=2510 polybar main &
polybar dummy &
MONITOR=HDMI1 polybar dummy &

echo launched
