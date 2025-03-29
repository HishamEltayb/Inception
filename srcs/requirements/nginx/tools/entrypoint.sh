#!/bin/sh

if [ ! -f /etc/self-signed.crt ]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -subj "/CN=$DOMAIN_NAME" \
        -addext "subjectAltName=DNS:$DOMAIN_NAME" \
        -keyout /etc/self-signed.key -out /etc/self-signed.crt
fi

nginx -g 'daemon off;'

