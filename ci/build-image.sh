#!/usr/bin/env bash

docker build -t ${SERVICE_DOCKER_IMAGE:-app} ${DOCKER_BUILD_ARGS} .
