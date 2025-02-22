#!/bin/bash

mainwp="/home/$USER/tools/wp/1st-monitor.jpg"
secondwp="/home/$USER/tools/wp/2nd-monitor.jpg"

monitors=$(xrandr --listmonitors | grep Monitors | awk '{print $2}')
echo -e "\e[32m $monitors displays detected\e[0m"
echo

if [ "$monitors" -eq 1 ]; then
    feh --bg-fill "$mainwp"
    echo -e "\e[32mSetting wallpaper for Main display\e[0m"

elif [ "$monitors" -eq 2 ]; then
    feh --bg-fill "$mainwp" "$secondwp"
    echo -e "\e[32mSetting wallpaper for Main and Second display\e[0m"
else
    echo -e "\e[33mYou don't need 3+ displays!\e[0m"
    exit 1
fi
