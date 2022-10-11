#! /bin/bash

TOP_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

IMAGE_NAME="redis"
IMAGE_TAG="7.0.0"
CONTAINER_NAME="redis"

docker run \
    -d \
    --restart=always \
    --name="${CONTAINER_NAME}" \
    --net=host \
    -v "${TOP_DIR}/data":/data \
    -v "${TOP_DIR}/conf":/etc/redis \
    "${IMAGE_NAME}":"${IMAGE_TAG}" \
    redis-server /etc/redis/redis.conf
