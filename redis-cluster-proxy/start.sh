#! /bin/bash

TOP_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

IMAGE_NAME="dup4/redis-cluster-proxy"
IMAGE_TAG="latest"
CONTAINER_NAME="redis-cluster-proxy"

docker run \
    -d \
    --restart=always \
    --name="${CONTAINER_NAME}" \
    -p 7777:7777 \
    -v "${TOP_DIR}/conf":/etc/redis-cluster-proxy/ \
    "${IMAGE_NAME}":"${IMAGE_TAG}" \
    redis-cluster-proxy -c /etc/redis-cluster-proxy/proxy.conf
