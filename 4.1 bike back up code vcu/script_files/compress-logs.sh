#!/bin/bash

LOG_PATH="/home/root/Logs/pdu.log"
LOG_PATH1="/home/root/Logs/logger.log"
LOGS_DIR="/home/root/Logs"
TIMESTAMP=$(date "+%Y-%m-%d_%H-%M-%S")
BACKUP_PATH="${LOGS_DIR}/logging_${TIMESTAMP}.log.gz"
BACKUP_PATH1="${LOGS_DIR}/pdu_${TIMESTAMP}.log.gz"

# Ensure logs directory exists
mkdir -p "${LOGS_DIR}"

# Check if log file exists and has content
if [ -s "${LOG_PATH}" ]; then
    # Compress with full content, preserving original file
    gzip -c "${LOG_PATH}" > "${BACKUP_PATH}"
    
    # Optional: Verify compression
    if [ $? -eq 0 ]; then
        # Truncate log file after successful backup
        > "${LOG_PATH}"
        echo "Log backed up successfully to ${BACKUP_PATH}"
    else
        echo "Compression failed"
    fi
else
    echo "Log file is empty or does not exist"
fi

# Check if log file exists and has content
if [ -s "${LOG_PATH1}" ]; then
    # Compress with full content, preserving original file
    gzip -c "${LOG_PATH1}" > "${BACKUP_PATH1}"

    # Optional: Verify compression
    if [ $? -eq 0 ]; then
        # Truncate log file after successful backup
        > "${LOG_PATH1}"
        echo "Log backed up successfully to ${BACKUP_PATH1}"
    else
        echo "Compression failed"
    fi
else
    echo "Log file is empty or does not exist"
fi
