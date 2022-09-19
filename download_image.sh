#!/bin/bash

. /root/baserow_vocabai_settings.sh

docker pull lucwastiaux/baserow-vocabai-plugin:${DOCKER_IMAGE_TAG}
