#!/bin/bash

# Rclone sync command script for unraid
# Documentation: https://rclone.org/onedrive/

# put current date as yyyy-mm-dd in $date
date=$(date '+%Y-%m')

# configure the log file
LOG_PATH="/mnt/user/backups/logs"
LOG_FILE_BASENAME="onedrive_sync_"
LOG_FILE_NAME="$LOG_FILE_BASENAME$date.log"
LOG_FILE="$LOG_PATH/$LOG_FILE_NAME"

# log file removal of old log files
find /mnt/user/backups/logs -name "$LOG_FILE_BASENAME" -mtime +30 -exec rm -f {} \;

# put current date as yyyy-mm-dd hh:mm:ss in $timestamp
timestamp=$(date +"%Y-%m-%d %T")
echo "OneDrive Sync Start - $timestamp" >> $LOG_FILE
# use rclone to sync onedrive at root level to local file path and log output
rclone sync onedrive:/ /mnt/user/backups/OneDrive >> $LOG_FILE
timestamp=$(date +"%Y-%m-%d %T")
echo "OneDrive Sync Stop  - $timestamp" >> $LOG_FILE