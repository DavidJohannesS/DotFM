#!/bin/bash

# Function to display the connected displays and highlight primary
function list_displays {
    connected_displays=$(xrandr --query | grep ' connected')
    primary_display=$(echo "$connected_displays" | grep ' primary' | cut -d ' ' -f 1)
    echo "Connected Displays:"
    while read -r line; do
        display=$(echo $line | cut -d ' ' -f 1)
        if [[ $display == $primary_display ]]; then
            echo -e "\e[32m$line\e[0m"  # Green color
        else
            echo "$line"
        fi
    done <<< "$connected_displays"
}

# Function to assign workspaces
function assign_workspaces {
    # Prompt user for workspace range or numbers
    read -p "Enter workspace numbers (e.g., 1-4 or 1,2,7): " workspaces

    # Prompt user for display to assign workspaces to
    echo "Select a display to assign workspaces to:"
    select display in $(xrandr --query | grep ' connected' | cut -d ' ' -f 1); do
        break
    done

    # Parse workspace range if specified
    if [[ $workspaces =~ [0-9]+-[0-9]+ ]]; then
        IFS='-' read -r start end <<< "$workspaces"
        workspace_array=($(seq $start $end))
    else
        IFS=',' read -ra workspace_array <<< "$workspaces"
    fi

    # Assign workspaces to the chosen display using i3-msg
    for workspace in "${workspace_array[@]}"; do
        i3-msg "workspace $workspace output $display"
    done

    echo "Workspaces $workspaces assigned to display $display"
}

# Main loop to allow continuous assignment
while true; do
    list_displays
    assign_workspaces

    # Prompt to continue or quit
    read -p "Do you want to assign more workspaces? (y/n): " choice
    if [[ $choice != [yY] ]]; then
        break
    fi
done

