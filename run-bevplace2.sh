#!/usr/bin/env bash

PROJECT_DIR=$(dirname "$(realpath "$0")")
IMAGE_NAME="bevplace_docker:latest"
CONTAINER_NAME="bevplace2-1"

echo "Starting Docker container ${CONTAINER_NAME}..."
echo "Running command: docker run -it --rm --network=host --ipc=host --gpus all -v ${PROJECT_DIR}:/data --name ${CONTAINER_NAME} ${IMAGE_NAME} /bin/bash"

docker run -it --rm \
    --network=host \
    --ipc=host \
    --gpus all \
    -v "${PROJECT_DIR}:/data" \
    --name "${CONTAINER_NAME}" \
    "${IMAGE_NAME}" \
    /bin/bash \
    -c "cd /data && python3 main.py --mode=train"