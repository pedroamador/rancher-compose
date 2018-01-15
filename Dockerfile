FROM  redpandaci/ubuntu-dind:latest

LABEL Mantainer Maurice Domínguez <maurice.ronet.dominguez@gmail.com>

WORKDIR /workspace

COPY entrypoint.sh /usr/bin/entrypoint.sh

RUN chmod u+x /usr/bin/entrypoint.sh

ENTRYPOINT ["/usr/bin/entrypoint.sh"]