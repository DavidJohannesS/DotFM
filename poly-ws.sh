#!/bin/bash
display=$(i3-msg -t get_workspaces | jq -r ".[] | select(.focused==true).output")
#while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
if pgrep -fx "polybar trayi" > /dev/null
then
    pkill -fx "polybar trayi"
else
MONITOR=$display polybar trayi &
fi


