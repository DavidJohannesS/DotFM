#!/bin/bash
display=$(i3-msg -t get_workspaces | jq -r ".[] | select(.focused==true).output")
#while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
if pgrep -fx "polybar example" > /dev/null
then
    pkill -fx "polybar example"
else
MONITOR=$display polybar example &
fi

