#! /bin/bash

function get_now_time() {
    # https://unix.stackexchange.com/questions/120484/what-is-a-standard-command-for-printing-a-date-in-rfc-3339-format
    NOW_TIME=$(date --rfc-3339=ns | sed 's/ /T/; s/\(\....\).*\([+-]\)/\1\2/g')
    echo "${NOW_TIME}"
}

function INFO() {
    echo -e "\033[0;32m$(get_now_time) [INFO]: $*\033[0m"
}

function ERROR() {
    echo -e "\033[0;31m$(get_now_time) [ERROR]: $*\033[0m"
}

function stop_current_container() {
    local container_name
    container_name="${1}"

    docker stop "${container_name}"
    docker rm "${container_name}"
}

function clean_old_images() {
    local image_name
    local image_tag
    local image_list
    image_name="${1}"
    image_tag="${2}"

    IFS=$'\n' read -d '' -r -a image_list <<<"$(docker images "${image_name}" | grep "${image_name}")"

    for image in "${image_list[@]}"; do
        tag="$(echo "${image}" | awk '{print $2}')"
        id="$(echo "${image}" | awk '{print $3}')"

        if [[ "${tag}" != "${image_tag}" ]]; then
            INFO "delete image. [name=${image_name}] [tag=${tag}] [id=${id}]"
            docker rmi "${id}"
        fi
    done
}
