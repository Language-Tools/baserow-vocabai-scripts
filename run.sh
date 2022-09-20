#!/bin/bash

HOSTNAME=`hostname`
. /root/baserow_vocabai_settings.sh


docker run \
  -d \
  --name baserow_vocabai \
  -e BASEROW_PUBLIC_URL=https://${HOSTNAME} \
  -e BASEROW_CADDY_ADDRESSES=https://${HOSTNAME} \
  -e CLOUDLANGUAGETOOLS_CORE_KEY=${CLOUDLANGUAGETOOLS_CORE_KEY} \
  -e BASEROW_TRIGGER_SYNC_TEMPLATES_AFTER_MIGRATION=false \
  -e BASEROW_CELERY_CLT_WORKER_NUM=3 \
  -v baserow_data:/baserow/data \
  -p 80:80 \
  -p 443:443 \
  --restart unless-stopped \
  lucwastiaux/baserow-vocabai-plugin:${DOCKER_IMAGE_TAG}
