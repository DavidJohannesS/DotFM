#!/bin/bash

# Check if both Polybars are running
if pgrep -fx "polybar example" > /dev/null 
then
    pkill -fx "polybar example"
else
    polybar example &
fi


