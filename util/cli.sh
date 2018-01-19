#!/bin/bash

print_args(){
    printf "%s\n" "${!ARGV[@]}" "${ARGV[@]}" | pr -2t
}

get_args(){
    POSITIONAL=()
    local cdm host project key secret
    cmd=$1

    while [[ $# -gt 0 ]]
    do
    option="$1"

    case $option in
        -h|--host)
        host="$2"
        shift # past argument
        shift # past value
        ;;
        -p|--project)
        project="$2"
        shift # past argument
        shift # past value
        ;;
        -k|--key)
        key="$2"
        shift # past argument
        shift # past value
        ;;
        -s|--secret)
        secret="$2"
        shift # past argument
        shift # past value
        ;;
        --default)
        DEFAULT=YES
        shift # past argument
        ;;
        *)    # unknown option
        POSITIONAL+=("$1") # save it in an array for later
        shift # past argument
        ;;
    esac
    done
    set -- "${POSITIONAL[@]}" # restore positional parameters

    ARGV["cmd"]=$cmd
    ARGV["host"]=$host
    ARGV["project"]=$project
    ARGV["key"]=$key
    ARGV["secret"]=$secret
}

show_help(){
cat << EOF
    Usage: cli COMANT[create|update] [OPTIONS]
    Run rancher-compose using a docker container using a docker-compose passed by pipe.
    Example: cat docker-compose | cli create -h <HOST:PORT/v1/> -p <PROJECT_NAME> -k <ENVIROMENT_KEY> -s <ENVIROMENT_SECRET>

    -h, --host          rancher host url
    -p, --project       project name
    -k, --key           enviroment api key
    -s, --secret        secret api key
EOF
}

exec() {
    local version host project key secret
    version="latest"
    cmd=$1
    host=$2
    project=$3
    key=$4
    secret=$5

    docker run \
    --rm \
    -i \
    -e EXEC=create \
    -e HOST=$host \
    -e PROJECT=$project \
    -e KEY=$key \
    -e SECRET=$secret \
    -e EXEC=$cmd \
    redpandaci/rancher-compose:$version  
}

main(){
    get_args "$@"
    if [ ${ARGV[cmd]} = "--help" ]; then
        show_help
    else
        exec ${ARGV[cmd]} ${ARGV[host]} ${ARGV[project]} ${ARGV[key]} ${ARGV[secret]}
    fi

    exit 0
}

declare -A ARGV
main "$@"