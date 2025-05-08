#!/bin/bash

# Dmenu-based power menu using doas instead of sudo

LOCKSCREEN_WALLPAPER="$HOME/docs/wallpapers/old/SoftAndClean.png"

main_menu() {
    echo -e "Shutdown\nReboot\nSleep\nLock\nCancel" | dmenu -i -p "Power Menu:"
}

pause_menu() {
    echo -e "now\n+60\n+45\n+30\n+15\n+10\n+5\n+3\n+2\n+1" | dmenu -i -p "Pause before action:"
}

# Get the selected action
action=$(main_menu)
[ -z "$action" ] && exit

case "$action" in
    "Shutdown")
        pause=$(pause_menu)
        [ -z "$pause" ] && exit
        notify-send "System:" "Shutdown scheduled - $pause"
        doas shutdown -P "$pause"
        ;;
    "Reboot")
        pause=$(pause_menu)
        [ -z "$pause" ] && exit
        notify-send "System:" "Reboot scheduled - $pause"
        doas shutdown -r "$pause"
        ;;
    "Sleep")
        notify-send "System:" "Suspending now"
        doas systemctl suspend
        ;;
    "Lock")
        if [ -f "$LOCKSCREEN_WALLPAPER" ]; then
            i3lock --show-failed-attempts --color=EEEEEE --image="$LOCKSCREEN_WALLPAPER" --tiling &
        else
            i3lock --show-failed-attempts --color=000000 &
        fi
        ;;
    "Cancel")
        notify-send "System:" "Shutdown command cancelled"
        doas shutdown -c
        ;;
    *)
        exit
        ;;
esac

