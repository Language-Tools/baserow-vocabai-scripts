#!/bin/bash

HOSTNAME=`hostname`

docker run \
  -d \
  --name baserow_vocabai \
  -e BASEROW_PUBLIC_URL=https://${HOSTNAME} \
  -e BASEROW_CADDY_ADDRESSES=https://${HOSTNAME} \
  -e CLOUDLANGUAGETOOLS_CORE_KEY=${CLOUDLANGUAGETOOLS_CORE_KEY} \
  -e BASEROW_TRIGGER_SYNC_TEMPLATES_AFTER_MIGRATION=false \
  -e BASEROW_AMOUNT_OF_WORKERS=2 \
  -v baserow_data:/baserow/data \
  -p 80:80 \
  -p 443:443 \
  --restart unless-stopped \
  lucwastiaux/baserow-vocabai-plugin:20220919.2
