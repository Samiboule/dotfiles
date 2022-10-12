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

#Get audio info
Audio() {
    VOL=$(pactl get-sink-volume 0 | awk -F/ 'FNR == 1 { gsub(/^[ \t]+/, "", $2); gsub(/[ \t]+$/, "", $2); print $2 }')
    MUTED=$(pactl get-sink-mute 0 | grep "yes")
    if [ -n "$MUTED" ]
    then
        echo "M"
    else
        echo "$VOL"
    fi
}

# Print everything
echo "%{r}$(Battery) | $(Audio) | $(Clock)"
