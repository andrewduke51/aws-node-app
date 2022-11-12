#!/usr/bin/env bash

ENVIRONMENT=$1

sed -i 's|%% ENV %%|'${ENVIRONMENT}'|g' ops/generated_config.yml
mv ops/generated_config.yml generated_config.yml
#mv ansible/playbooks/${ENVIRONMENT}-inventory ${ENVIRONMENT}-inventory