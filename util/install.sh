#!/bin/bash


download_cli(){
    local url
    url=$1
    path=$2
    curl -o $path $url
}

install(){
    local url path version
    version="develop"
    path="/usr/local/bin/redpanda-rancher"
    url="https://raw.githubusercontent.com/red-panda-ci/rancher-compose/$version/util/cli.sh"

    echo "Instaling redpanda-rancher"
    download_cli $url $path;
    chmod +x $path
    echo "done"
}


install