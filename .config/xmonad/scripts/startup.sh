#!/bin/sh

feh --no-fehbg --bg-fill ~/.config/xmonad/wallpapers/etna.png
stalonetray -c ~/.config/stalonetray/stalonetrayrc &
nm-applet &
xcompmgr &
