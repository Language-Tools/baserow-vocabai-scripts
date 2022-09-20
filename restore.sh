#!/bin/bash

BACKUP_DIR=$HOME/backup
BACKUP_FILENAME=baserow_vocabai_`hostname`.tar.gz

echo "restoring ${BACKUP_DIR}/${BACKUP_FILENAME} in 10s"
sleep 10

echo "stopping baserow vocabai container"
docker stop baserow_vocabai

echo "restoring"
docker run --rm -v baserow_data:/baserow/data -v $BACKUP_DIR:/backup ubuntu bash -c "rm -rvf /baserow/data && mkdir -p /baserow/data && cd /baserow/data && tar xvf /backup/${BACKUP_FILENAME} --strip-components=2"
