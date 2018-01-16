#!/bin/sh

set -xe

rancher_exec(){
  local cmd host project key secret
  cmd=$1
  host=$2
  project=$3
  key=$4
  secret=$5

  rancher-compose --project-name $project --url $host --access-key $key --secret-key $secret --verbose $cmd
}

deploy(){
  local host project key secret
  host=$1
  project=$2
  key=$3
  secret=$4

  rancher_exec "create" $host $project $key $secret
  rancher_exec "start" $host $project $key $secret
}

update_deployment(){
  local host project key secret
  host=$1
  project=$2
  key=$3
  secret=$4

  rancher-compose --project-name $project \
  --url $host \
  --access-key $key \
  --secret-key $secret \
  up -d --force-upgrade --pull --confirm-upgrade
}

write_docker_compose_from_pipe(){
  local IFS; IFS=''
  
  while read data; do
    echo "$data" >> docker-compose.yml
  done
}

main() {
    write_docker_compose_from_pipe;

    if [ "$EXEC" = "create" ]; then
        deploy $HOST $PROJECT $KEY $SECRET;
    elif [ "$EXEC" = "update" ]; then
        update_deployment $HOST $PROJECT $KEY $SECRET;
    fi
}

main