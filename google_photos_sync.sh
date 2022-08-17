#!/bin/bash

# Rclone sync command script for unraid
# Documentation: https://rclone.org/googlephotos/

# put current date as yyyy-mm-dd in $date
date=$(date '+%Y-%m')

# configure the log file
LOG_PATH="/mnt/user/backups/logs"
LOG_FILE_BASENAME="google_photos_sync_"
LOG_FILE_NAME="$LOG_FILE_BASENAME$date.log"
LOG_FILE="$LOG_PATH/$LOG_FILE_NAME"

# log file removal of old log files
find /mnt/user/backups/logs $LOG_FILE_BASENAME -mtime +180 -exec rm {} \;

# put current date as yyyy-mm-dd hh:mm:ss in $timestamp
timestamp=$(date +"%Y-%m-%d %T")
echo "Google Photos Sync Start - $timestamp" >> $LOG_FILE
# sync google photos by 'by-month' or 'by-year' as there is not a traditional file structure
rclone sync google_photos:media/by-year /mnt/user/backups/Google_Photos >> $LOG_FILE
timestamp=$(date +"%Y-%m-%d %T")
echo "Google Photos Sync Stop  - $timestamp" >> $LOG_FILE
