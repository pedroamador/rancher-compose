# rancher-compose

Deploy or update projects on a rancher Server.
_Supported tags and respective `Dockerfile` links:_
[`test`, `latest`, `1.0.0`](Dockerfile)

## How does it work?

It is a bash wrapper that uses a rancher-compose image to have delocalised infrastructure.

## Install CLI script

using curl:

```sh

curl -o- https://raw.githubusercontent.com/red-panda-ci/rancher-compose/1.0.0/util/install.sh | bash

```

or Wget:

```sh

wget -qO- https://raw.githubusercontent.com/red-panda-ci/rancher-compose/1.0.0/util/install.sh | bash

```
## Use

Using docker image:

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

```
Using cli:

```bash

redpanda-rancher create -h <HOST>:<PORT>/v1/ -p <PROJECT> -k <ENVIRONMENT_KEY> -s <ENVIRONMENT_SECRET> -f /some/path/docker-compose.yml
``` 
## version

- rancher-compose `v0.12.5`

## CLI commands

* create
* update
* auth
* uninstall
* --help

## How to develop?

- run `npm install`
- upgrade Dockerfile
- run `npm test` or `bin/test.sh`
- commit your changes
- publish new image or execute bin/publish.sh <VERSION>

## Considerations

_This project only uses `npm` to do [commit validations](https://github.com/willsoto/validate-commit) and verify [Dockerfile coding style](https://github.com/redcoolbeans/dockerlint)._