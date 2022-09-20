#!/bin/bash

BACKUP_DIR=$HOME/backup
BACKUP_FILENAME=baserow_vocabai_`hostname`.tar.gz

echo "downloading backup from rclone"
rclone sync -v wasabi:baserow-vocabai-backup/$BACKUP_FILENAME  $BACKUP_DIR