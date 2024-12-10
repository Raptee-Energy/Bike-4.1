#!/bin/bash

# Array of services to start
services=("pdu" "logging" "obc" "bt-init" "btkey" "flutter-pi")

# Loop through each service
for service in "${services[@]}"; do
    # Start the service
    systemctl start "$service"
    
    # Check if the service is active
    if systemctl is-active --quiet "$service"; then
        echo "$service is up and running"
    else
        echo "Failed to start $service"
    fi
done
