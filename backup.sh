#!/bin/bash

BACKUP_DIR=$HOME/backup
BACKUP_FILENAME=baserow_vocabai_`hostname`.tar.gz
mkdir -p ${BACKUP_DIR}

docker stop baserow_vocabai
docker run --rm -v baserow_data:/baserow/data -v $BACKUP_DIR:/backup ubuntu tar cvzf /backup/${BACKUP_FILENAME} /baserow/data

docker start baserow_vocabai