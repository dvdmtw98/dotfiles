#!/usr/bin/env bash

# Ordered labels for display
actions=("Kill Process" "Suspend" "Reboot" "Shutdown")

# Map labels to their case keys
declare -A keys=(
    ["Kill Process"]="kill"
    ["Suspend"]="suspend"
    ["Reboot"]="reboot"
    ["Shutdown"]="shutdown"
)

# Show the menu
choice=$(printf '%s\n' "${actions[@]}" | dmenu -i -c -l "${#actions[@]}" -p "Select Action:")

# Map choice to key (for case matching)
key="${keys[$choice]}"
case "$key" in
    kill)
        ps -u "$USER" -o pid,comm,%cpu,%mem | dmenu -i -c -l 10 -p "Kill:" | awk '{print $1}' | xargs -r kill
        ;;
    suspend)
        slock && systemctl suspend -i
        ;;
    reboot)
        systemctl reboot -i
        ;;
    shutdown)
        systemctl poweroff
        ;;
    *)
        exit 1
        ;;
esac
