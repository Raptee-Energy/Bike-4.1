#!/bin/bash

# Array of services to check and stop
services=("pdu" "logging" "obc" "bt-init" "btkey")

# Loop through each service
for service in "${services[@]}"; do
    # Check if the service is active (running)
    if systemctl is-active --quiet "$service"; then
        echo "$service is running. Stopping it now..."
        # Stop the service
        systemctl stop "$service"
        if [ $? -eq 0 ]; then
            echo "$service has been stopped."
        else
            echo "Failed to stop $service."
        fi
    else
        echo "$service is already stopped."
    fi
done
