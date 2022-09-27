#!/bin/sh

#~/.config/xmonad/scripts/lemonbar.sh | lemonbar -B #000000 -f "JetBrains Mono"

#Define the clock
Clock() {
    DATETIME=$(date "+%a %b %d, %T")

    echo "$DATETIME"
}

#Define the battery
Battery() {
    BAT1PERC=$(cat /sys/class/power_supply/BAT1/capacity)
    BAT2PERC=$(cat /sys/class/power_supply/BAT2/capacity)
    BAT1STATUS=$(cat /sys/class/power_supply/BAT1/status)
    BAT2STATUS=$(cat /sys/class/power_supply/BAT2/status)
    echo "$BAT1STATUS B1: $BAT1PERC% | $BAT2STATUS B2: $BAT2PERC%"
}

#Get xmonad info
XmonadInfo() {
    read -r xmonad
    echo "$xmonad"
}

#Get audio info
Audio() {
    EVERYTHING=$(amixer get Master)
    MUTED=$(echo "$EVERYTHING" | grep "off")
    if [ -n "$MUTED" ]
    then
        echo "M"
    else
        echo "$(echo "$EVERYTHING" | grep -i "left: playback" | sed 's/[^\[]*\[//' | sed 's/%.*//')%"
    fi
}

# Print everything
while true; do
    echo "%{l}$(XmonadInfo)%{r}$(Battery) | $(Audio) | $(Clock)"
        sleep 0.1
done
