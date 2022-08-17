#!/bin/bash
#
# S3 Rclone sync command script for unraid
# Documentation: https://rclone.org/s3/

# put current date as yyyy-mm in $date
date=$(date '+%Y-%m')

# configure the log file
LOG_PATH="/mnt/user/backups/logs"
LOG_FILE_BASENAME="s3_sync_"
LOG_FILE_NAME="$LOG_FILE_BASENAME$date.log"
LOG_FILE="$LOG_PATH/$LOG_FILE_NAME"

# log file removal of old log files
find /mnt/user/backups/logs -name "$LOG_FILE_BASENAME" -mtime +30 -exec rm -f {} \;

# put current date as yyyy-mm-dd hh:mm:ss in $timestamp
timestamp=$(date +"%Y-%m-%d %T")
echo "S3 Sync Start - $timestamp" >> $LOG_FILE
# use rclone to sync ALL s3 buckets to local file path and log output
rclone sync s3:/ /mnt/user/backups/S3 >> $LOG_FILE
timestamp=$(date +"%Y-%m-%d %T")
echo "S3 Sync Stop  - $timestamp" >> $LOG_FILE
