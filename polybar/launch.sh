#!/bin/bash

killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
polybar topbar 2>&1 | tee -a /tmp/polybar.log & disown

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload topbar 2>&1 | tee -a /tmp/polybar.log & disown
  done
else
  polybar --reload topbar 2>&1 | tee -a /tmp/polybar.log & disown
fi