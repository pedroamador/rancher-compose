# rancher-compose

_rancher-compose cli dockerized._

_Supported tags and respective `Dockerfile` links:_
[`test`, `latest`, `1.0.0`](Dockerfile)

### Install script

using cURL:

```sh

curl -o- https://raw.githubusercontent.com/red-panda-ci/rancher-compose/develop/util/install.sh | bash

```

or Wget:

```sh

wget -qO- https://raw.githubusercontent.com/red-panda-ci/rancher-compose/develop/util/install.sh | bash

```
## Use

```bash

cat docker-compose.yml | \
docker run \
--rm \
-i \
-e HOST=<HOST>:<PORT>/v1/ \
-e PROJECT=<PROJECT> \
-e KEY=<ENVIRONMENT_KEY> \
-e SECRET=<ENVIRONMENT_SECRET> \
-e EXEC=create \
redpandaci/rancher-compose:1.0.0

# usage with cli util

redpanda-rancher create -h <HOST>:<PORT>/v1/ -p <PROJECT> -k <ENVIRONMENT_KEY> -s <ENVIRONMENT_SECRET> -f /some/path/docker-compose.yml
redpanda-rancher update -h <HOST>:<PORT>/v1/ -p <PROJECT> -k <ENVIRONMENT_KEY> -s <ENVIRONMENT_SECRET> -f /some/path/docker-compose.yml

# show help

redpanda-rancher --help

```

## version

- rancher-compose `v0.12.5`

## commands

* create
* update

## How to develop?

- run `npm install`
- upgrade Dockerfile
- run `npm test` or `bin/test.sh`
- commit your changes
- publish new image

## Considerations

_This project only uses `npm` to do [commit validations](https://github.com/willsoto/validate-commit) and verify [Dockerfile coding style](https://github.com/redcoolbeans/dockerlint)._