#!/bin/sh

feh --no-fehbg --bg-fill ~/.config/xmonad/wallpapers/aoko.png
stalonetray -c ~/.config/stalonetray/stalonetrayrc &
nm-applet &
fcitx -d &
xcompmgr &
