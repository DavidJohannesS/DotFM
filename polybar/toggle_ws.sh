#!/bin/bash

# Check if both Polybars are running
if pgrep -fx "polybar numbers" > /dev/null && pgrep -fx "polybar numbers1" > /dev/null
then
    # If both are running, kill both
    pkill -fx "polybar numbers"
    pkill -fx "polybar numbers1"
else
    # If one or neither is running, start both
    pkill -fx "polybar numbers"  # Ensure clean state
    pkill -fx "polybar numbers1" # Ensure clean state
    polybar numbers &
    polybar numbers1 &
fi

