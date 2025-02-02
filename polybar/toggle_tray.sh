#!/bin/bash

# Check if both Polybars are running
if pgrep -fx "polybar trayi" > /dev/null 
then
    # If both are running, kill both
    pkill -fx "polybar trayi"
else
    # If one or neither is running, start both
    polybar trayi &
fi

