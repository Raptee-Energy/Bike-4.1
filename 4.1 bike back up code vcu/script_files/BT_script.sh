#!/bin/bash
 
#max_attempts=10
#attempt=0
 
# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}
 
while true; do
    #attempt=$((attempt+1))
    #log_message "Attempt $attempt of $max_attempts"
    # Check serial port
    if [ ! -e /dev/ttyS3 ]; then
        log_message "Serial port /dev/ttyS3 does not exist. Retrying..."
        sleep 5
        continue
    fi
    # Attempt hciattach
    if hciattach /dev/ttyS3 bcm43xx 115200 noflow -; then
        log_message "hciattach successful"
        # Bring up Bluetooth interface
        if hciconfig hci0 up; then
            log_message "Bluetooth interface up"
            # Run the program and check its exit status
            log_message "Starting BT_keyfob program"
            systemctl restart btkey
            program_exit=$?
            if [ $program_exit -ne 0 ]; then
		#systemctl stop btkey
                log_message "BT_keyfob program failed with exit code $program_exit. Restarting..."
                attempt=0  # Reset attempt counter for a fresh start
                continue
            else
                log_message "BT_keyfob program completed successfully"
                exit 0
            fi
        else
            log_message "Failed to bring up Bluetooth interface. Retrying..."
        fi
    else
        log_message "hciattach failed. Retrying..."
    fi
    # Check if we've exceeded maximum attempts
    if [ $attempt -ge $max_attempts ]; then
        log_message "Failed to initialize Bluetooth after $max_attempts attempts"
        exit 1
    fi
    sleep 5
done
