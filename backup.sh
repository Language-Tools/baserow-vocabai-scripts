#!/bin/bash

BACKUP_DIR=$HOME/backup
BACKUP_FILENAME=baserow_vocabai_`hostname`.tar.gz
BACKUP_MD5=${BACKUP_FILENAME}.md5
mkdir -p ${BACKUP_DIR}

echo "stopping container"
docker stop baserow_vocabai

echo "running backup"
docker run --rm -v baserow_data:/baserow/data -v $BACKUP_DIR:/backup ubuntu tar czf /backup/${BACKUP_FILENAME} /baserow/data

echo "restarting container"
docker start baserow_vocabai

echo "computing md5 hash"
md5sum ${BACKUP_DIR}/${BACKUP_FILENAME} > ${BACKUP_DIR}/${BACKUP_MD5}

echo "running rclone"
rclone copy -v $BACKUP_DIR wasabi:baserow-vocabai-backup