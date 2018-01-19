
#!/usr/bin/env bash

TAG=$1
docker run \
--rm \
-i \
--name rancher-compose \
-e HOST="http://163.172.182.214:8080/v1/" \
-e PROJECT=blog-api \
-e KEY=885B5B6B02D06E03B584 \
-e SECRET=sj9gs3JUzXJGR9jYN63v5XpCUuVTWhMrzncJPprm \
-e EXEC=create \
redpandaci/rancher-compose:$TAG