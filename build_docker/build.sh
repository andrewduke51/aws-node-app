#!/bin/bash

echo "${DOCKERHUB_PASS}" | docker login -u "${DOCKERHUB_USERNAME}" --password-stdin
docker build -t andrewduke51/nodeapp:latest .
docker push andrewduke51/nodeapp:latest