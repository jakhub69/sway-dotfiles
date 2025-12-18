#!/bin/sh

BEMENU_OPTS="-i --fb #303446 --ff #c6d0f5 --nb #303446 --nf #c6d0f5 --tb #303446 --hb #303446 --tf #e78284 --hf #e5c890 --af #c6d0f5 --ab #303446 --fn 'CommitMono 13'"
OPTIONS="󰌾 Lock\n󰗼 Logout\n󰜉 Reboot\n󰐥 Poweroff\n󰤄 Suspend"
ACTION=$(printf "$OPTIONS" | bemenu $BEMENU_OPTS -p "System:")

[ -z "$ACTION" ] && exit

CONFIRM=$(printf "No\nYes" | bemenu $BEMENU_OPTS -p "Are you sure you want to: $ACTION?")

if [ "$CONFIRM" = "Yes" ]; then
    case "$ACTION" in
        *Lock)     swaylock -f ;;
        *Logout)   swaymsg exit ;;
        *Reboot)   systemctl reboot ;;
        *Poweroff) systemctl poweroff ;;
        *Suspend)  systemctl suspend ;;
    esac
fi
