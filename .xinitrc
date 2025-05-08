setxkbmap -layout us,ara -variant ,digits -option grp:sclk_toggle
xmodmap -e "clear Lock" -e "keycode 9 = Caps_Lock" -e "keycode 66 = Escape"
~/.local/bin/dwm_status.sh &
sxhkd &
xsetroot -solid "#1e1e2e" &
exec dwm
