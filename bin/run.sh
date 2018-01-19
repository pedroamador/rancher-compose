#!/usr/bin/env bash

docker run \
--rm \
-i \
--name rancher-compose \
-e HOST=$1 \
-e PROJECT=$2 \
-e KEY=$3 \
-e SECRET=$4 \
-e EXEC=$5 \
redpandaci/rancher-compose:1.0.0