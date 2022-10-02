#!/bin/sh

feh --no-fehbg --bg-fill ~/.config/xmonad/wallpapers/pripara.jpg
stalonetray -c ~/.config/stalonetray/stalonetrayrc &
nm-applet &
fcitx -d &
xcompmgr &
