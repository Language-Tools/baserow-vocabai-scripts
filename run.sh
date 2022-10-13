#!/bin/bash

HOSTNAME=`hostname`
. /root/baserow_vocabai_settings.sh

if [[ -z "${CLOUDLANGUAGETOOLS_CORE_KEY}" ]]; then
  echo "CLOUDLANGUAGETOOLS_CORE_KEY not set"
  exit 1
fi

if [[ -z "${BASEROW_USER_STATS_URL}" ]]; then
  echo "BASEROW_USER_STATS_URL not set"
  exit 1
fi

if [[ -z "${BASEROW_USER_STATS_TOKEN}" ]]; then
  echo "BASEROW_USER_STATS_TOKEN not set"
  exit 1
fi

if [[ -z "${EMAIL_SMTP_USER}" ]]; then
  echo "EMAIL_SMTP_USER not set"
  exit 1
fi

if [[ -z "${EMAIL_SMTP_PASSWORD}" ]]; then
  echo "EMAIL_SMTP_PASSWORD not set"
  exit 1
fi


docker run \
  -d \
  --name baserow_vocabai \
  -e BASEROW_PUBLIC_URL=https://${HOSTNAME} \
  -e BASEROW_CADDY_ADDRESSES=https://${HOSTNAME} \
  -e CLOUDLANGUAGETOOLS_CORE_KEY=${CLOUDLANGUAGETOOLS_CORE_KEY} \
  -e BASEROW_TRIGGER_SYNC_TEMPLATES_AFTER_MIGRATION=false \
  -e BASEROW_CELERY_CLT_WORKER_NUM=3 \
  -e BASEROW_USER_STATS_URL=${BASEROW_USER_STATS_URL} \
  -e BASEROW_USER_STATS_TOKEN=${BASEROW_USER_STATS_TOKEN} \
  -e FROM_EMAIL=luc@vocab.ai \
  -e EMAIL_SMTP=yes \
  -e EMAIL_SMTP_USE_TLS=yes \
  -e EMAIL_SMTP_HOST=smtp.postmarkapp.com \
  -e EMAIL_SMTP_PORT=25 \
  -e EMAIL_SMTP_USER=${EMAIL_SMTP_USER} \
  -e EMAIL_SMTP_PASSWORD=${EMAIL_SMTP_PASSWORD} \
  -v baserow_data:/baserow/data \
  -p 80:80 \
  -p 443:443 \
  --restart unless-stopped \
  lucwastiaux/baserow-vocabai-plugin:${DOCKER_IMAGE_TAG}
