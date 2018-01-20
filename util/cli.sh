#!/bin/bash

CLI_VERSION="v1.0.0"
RANCHER_COMPOSE_VERSION="v0.12.5"
CLI_PATH="/usr/local/bin/redpanda-rancher"
CONFIG_PATH=~/.rancher-redpanda
AUTH_FILE=auth
AUTH_FILE_PATH=$CONFIG_PATH/$AUTH_FILE


print_args(){
    printf "%s\n" "${!ARGV[@]}" "${ARGV[@]}" | pr -2t
}

get_args_from_user_params(){
    POSITIONAL=()
    local cdm host project key secret file
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
        shift
        shift
        ;;
        -k|--key)
        key="$2"
        shift
        shift
        ;;
        -s|--secret)
        secret="$2"
        shift
        shift
        ;;
        -f|--file)
        file="$2"
        shift
        shift
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
    ARGV["file"]=$file
}

get_args_from_auth_file(){
    local key value IFS auth
    while IFS="=" read key value
    do
        ARGV[$key]=$value
    done < <(cat $AUTH_FILE_PATH)
}

get_args(){
    get_args_from_user_params "$@"

    if [ -e $AUTH_FILE_PATH ]; then
        get_args_from_auth_file
    fi
}

validate_args(){
    local isValidUrl host
    isValidUrl='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
    host=${ARGV[host]}

    if [[ ! $host =~ $isValidUrl ]]
    then
        echo "Invalid host: $host"
        exit 1
    fi

    for key in ${!ARGV[@]}
    do
        if [ -z $(echo -e ${ARGV[$key]} | tr -d '[:space:]') ]; then
            echo "Invalid value for $key, use --help"
            exit 1  
        fi
    done
}

show_help(){
cat << EOF
    Usage: redpanda-rancher COMMAND [OPTIONS]

    Commands:

    create      Deploy a project 
    update      Update a deployed project     
    auth        Set rancher host auth
    uninstall   Remove redpanda-rancher cli
    
    Options:

    -h, --host      Rancher host
    -p --project    Project name
    -k --key        Enviroment key
    -s --secret     Enviroment secret 
    -f --file       Path to docker-compose file

    Examples:

        Example: 

            redpanda-rancher create -h <HOST:PORT/v1/> -p <PROJECT_NAME> -k <ENVIROMENT_KEY> -s <ENVIROMENT_SECRET> -f docker-compose.yml
        
        Example with auth:
        
            redpanda-rancher auth
            redpanda-rancher create -p <PROJECT_NAME> -f docker-compose.yml

EOF
}

show_version(){
    echo "redpanda-rancher $CLI_VERSION, rancher-compose $RANCHER_COMPOSE_VERSION"
}

store_auth_from_user_input(){
    local host key secret
    echo 'Rancher host:'; read host
    echo 'Enviroment API key:'; read -s key
    echo 'Enviroment API secret:'; read -s secret

    mkdir -p $CONFIG_PATH

    echo "host=$host" > $AUTH_FILE_PATH
    echo "key=$key" >> $AUTH_FILE_PATH
    echo "secret=$secret" >> $AUTH_FILE_PATH
}

exec() {
    local cmd host project key secret file version
    cmd=$1
    host=$2
    project=$3
    key=$4
    secret=$5
    file=$6
    version="latest"

    cat $file | \
    docker run \
    --rm \
    -i \
    -e EXEC=$cmd \
    -e HOST=$host \
    -e PROJECT=$project \
    -e KEY=$key \
    -e SECRET=$secret \
    -e EXEC=$cmd \
    redpandaci/rancher-compose:$version  
}

remove_cli(){
    rm -rf $CONFIG_PATH
    rm -rf $CLI_PATH
}

declare -A ARGV
main(){
    get_args "$@"

    case ${ARGV[cmd]} in
    --help)
        show_help
    ;;
    --version|-v)
        show_version
    ;;
    auth)
        store_auth_from_user_input
    ;;
    create|update)
        validate_args
        exec ${ARGV[cmd]} ${ARGV[host]} ${ARGV[project]} ${ARGV[key]} ${ARGV[secret]} ${ARGV[file]}
    ;;
    uninstall)
        remove_cli
    ;;
    *)  
        show_version
        show_help
        echo "command not found"
    ;;
    esac
    exit 0
}

main "$@"