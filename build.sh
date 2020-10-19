#!/usr/bin/env bash
IMAGE_NAME="haakco/jenkins"
docker build --rm -t ${IMAGE_NAME} .
