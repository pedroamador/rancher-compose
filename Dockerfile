FROM  alpine:latest

LABEL Mantainer Maurice Domínguez <maurice.ronet.dominguez@gmail.com>

WORKDIR /workspace

ENV RANCHER_COMPOSE_VERSION 0.12.5
RUN wget https://github.com/rancher/rancher-compose/releases/download/v$RANCHER_COMPOSE_VERSION/rancher-compose-linux-amd64-v$RANCHER_COMPOSE_VERSION.tar.gz && \
    tar zxf rancher-compose-linux-amd64-v$RANCHER_COMPOSE_VERSION.tar.gz && \
    mv rancher-compose-v$RANCHER_COMPOSE_VERSION/rancher-compose /usr/local/bin/rancher-compose && \
    chmod +x /usr/local/bin/rancher-compose && \
    rm rancher-compose-linux-amd64-v$RANCHER_COMPOSE_VERSION.tar.gz && \
    rm -r rancher-compose-v$RANCHER_COMPOSE_VERSION

COPY entrypoint.sh /usr/bin/entrypoint.sh

RUN chmod u+x /usr/bin/entrypoint.sh

CMD ["/usr/bin/entrypoint.sh"]