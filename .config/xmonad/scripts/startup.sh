#!/bin/sh

feh --no-fehbg --bg-fill ~/.config/xmonad/wallpapers/pripara.jpg
wmname "LG3D"
stalonetray -c ~/.config/stalonetray/stalonetrayrc &
nm-applet &
pnmixer &
xcompmgr &
