FROM alpine:3.20

RUN apk update

RUN apk add mariadb mariadb-client openrc

RUN mkdir -p /run/openrc && touch /run/openrc/softlevel

RUN openrc

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh


ENTRYPOINT [ "/entrypoint.sh" ]