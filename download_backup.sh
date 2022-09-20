#!/bin/bash

BACKUP_DIR=$HOME/backup
BACKUP_FILENAME=baserow_vocabai_`hostname`.tar.gz
BACKUP_MD5=${BACKUP_FILENAME}.md5

echo "downloading backup from rclone"
rclone copy -v wasabi:baserow-vocabai-backup/$BACKUP_FILENAME  $BACKUP_DIR
rclone copy -v wasabi:baserow-vocabai-backup/$BACKUP_MD5  $BACKUP_DIR