FROM alpine:3.20

RUN apk update

RUN apk add mariadb mariadb-client openrc

RUN mkdir -p /run/openrc && touch /run/openrc/softlevel


ENTRYPOINT [ "/bin/sh" ]