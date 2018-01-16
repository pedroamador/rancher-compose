#!/bin/bash

declare -A ARGV

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

get_args "$@"

printf "%s\n" "${!ARGV[@]}" "${ARGV[@]}" | pr -2t