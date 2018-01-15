
#!/usr/bin/env bash

TAG=$1
docker run \
--privileged \
--rm \
--name rancher-compose \
redpandaci/rancher-compose:$TAG