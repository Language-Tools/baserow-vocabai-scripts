#!/bin/bash

BACKUP_DIR=$HOME/backup
BACKUP_FILENAME=baserow_vocabai_`hostname`.tar.gz
mkdir -p ${BACKUP_DIR}

echo "stopping container"
docker stop baserow_vocabai

echo "running backup"
docker run --rm -v baserow_data:/baserow/data -v $BACKUP_DIR:/backup ubuntu tar czf /backup/${BACKUP_FILENAME} /baserow/data

echo "restarting container"
docker start baserow_vocabai

echo "running rclone"
rclone sync -v $BACKUP_DIR/$BACKUP_FILENAME wasabi:baserow-vocabai-backup