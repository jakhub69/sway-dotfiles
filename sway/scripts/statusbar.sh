#!/bin/sh

# ---------------- CPU Usage (Dynamic & Rounded) ----------------
cpu=$(grep 'cpu ' /proc/stat)
idle=$(echo $cpu | awk '{print $5+$6}')
total=$(echo $cpu | awk '{print $2+$3+$4+$5+$6+$7+$8}')

sleep 0.2

cpu_new=$(grep 'cpu ' /proc/stat)
idle_new=$(echo $cpu_new | awk '{print $5+$6}')
total_new=$(echo $cpu_new | awk '{print $2+$3+$4+$5+$6+$7+$8}')

cpu_usage=$(echo "$idle $total $idle_new $total_new" | awk '{print int(100 * (1 - ($3 - $1) / ($4 - $2)) + 0.5)}' )
cpu_display="󰍛 $cpu_usage%"

# ---------------- RAM Usage ----------------
ram=$(free -h | awk '/^Mem:/ {print "󰘚 " $3 "/" $2}')

# ---------------- Disk Usage ----------------
# Wyciąga zajęte miejsce na głównej partycji /
disk=$(df -h / | awk 'NR==2 {print "󰋊 " $3 "/" $2}')

# ---------------- Network ----------------
if ip link show | grep -E "state UP" | grep -qE "eth|enp|eno"; then
    net_icon="󰈀"
    network="$net_icon Wired"
else
    wifi=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
    if [ -n "$wifi" ]; then
        network="󰖩 $wifi"
    else
        network="󰖪 No Net"
    fi
fi

# ---------------- Volume ----------------
vol_line=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
vol_val=$(echo "$vol_line" | awk '{printf "%d\n", $2 * 100}')
if echo "$vol_line" | grep -q "\[MUTED\]"; then
    vol_icon="󰖁"
else
    vol_icon="󰖀"
fi
volume="$vol_icon $vol_val%"

# ---------------- Clock ----------------
# %A to pełna nazwa dnia tygodnia
clock="$(date '+󰥔 %H:%M 󰃭 %A, %d.%m.%Y')"

# ---------------- Combine ----------------
echo "$cpu_display | $ram | $disk | $network | $volume | $clock"
