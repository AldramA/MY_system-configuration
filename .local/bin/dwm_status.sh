#!/bin/sh

usbmon() {
    usb1=$(lsblk -la | awk '/sdc1/ { print $1 }')
    usb1mounted=$(lsblk -la | awk '/sdc1/ { print $7 }')

    if [ "$usb1" ]; then
        if [ -z "$usb1mounted" ]; then
            echo " |"
        else
            echo " $usb1 |"
        fi
    else
        echo ""
    fi
}

fsmon() {
    ROOTPART=$(df -h | awk '/\/$/ { print $3 }') 
    HOMEPART=$(df -h | awk '/\/home/ { print $3 }') 
    SWAPPART=$(awk '/\// { print $4 }' /proc/swaps)

    echo "  $ROOTPART   $HOMEPART   $SWAPPART"
}

ram() {
    mem=$(free -h | awk '/Mem:/ { print $3 }' | cut -f1 -d 'i')
    echo  "$mem"
}

cpu() {
    read -r cpu a b c previdle rest < /proc/stat
    prevtotal=$((a + b + c + previdle))
    sleep 0.5
    read -r cpu a b c idle rest < /proc/stat
    total=$((a + b + c + idle))
    usage=$((100 * ((total - prevtotal) - (idle - previdle)) / (total - prevtotal) ))
    echo  "$usage"% 
}

network() {
    conntype=$(ip route | awk '/default/ { print substr($5,1,1) }')

    if [ -z "$conntype" ]; then
        echo " down"
    elif [ "$conntype" = "e" ]; then
        echo " up"
    elif [ "$conntype" = "w" ]; then
        echo " up"
    fi
}

volume() {
    if command -v pactl >/dev/null 2>&1; then
        # PulseAudio
        muted=$(pactl list sinks | awk '/Mute:/ { print $2 }')
        vol=$(pactl list sinks | grep 'Volume:' | awk 'FNR == 1 { print $5 }' | cut -d'%' -f1)

        if [ "$muted" = "yes" ]; then
            echo " muted"
        else
            if [ "$vol" -ge 65 ]; then
                echo " $vol%"
            elif [ "$vol" -ge 40 ]; then
                echo " $vol%"
            else
                echo " $vol%"
            fi
        fi
    else
        # ALSA
        mono=$(amixer -M sget Master | grep Mono: | awk '{ print $2 }')

        if [ -z "$mono" ]; then
            muted=$(amixer -M sget Master | awk 'FNR == 6 { print $7 }' | sed 's/[][]//g')
            vol=$(amixer -M sget Master | awk 'FNR == 6 { print $5 }' | sed 's/[][]//g; s/%//g')
        else
            muted=$(amixer -M sget Master | awk 'FNR == 5 { print $6 }' | sed 's/[][]//g')
            vol=$(amixer -M sget Master | awk 'FNR == 5 { print $4 }' | sed 's/[][]//g; s/%//g')
        fi

        if [ "$muted" = "off" ]; then
            echo " muted"
        else
            if [ "$vol" -ge 65 ]; then
                echo " $vol%"
            elif [ "$vol" -ge 40 ]; then
                echo " $vol%"
            else
                echo " $vol%"
            fi
        fi
    fi
}

clock() {
    dte=$(date +"%d-%m-%Y")
    time=$(date +"%I:%M")
    echo " $dte  $time"
}

main() {
    while true; do
        xsetroot -name " $(usbmon) $(ram) | $(cpu) | $(network) | $(volume) | $(clock)"
        sleep 2
    done
}

main

