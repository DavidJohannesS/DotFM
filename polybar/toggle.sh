#!/bin/bash
# Check if Polybar is running
if pgrep -x "polybar" > /dev/null
then
    # If running, kill Polybar
    pkill polybar
else
    # If not running, start Polybar
    polybar trayi & polybar numbers & polybar numbers1 &
fi

