FROM alpine:latest

RUN apk update && apk upgrade

RUN apk add --no-cache nginx curl

RUN mkdir -p /data/www 

COPY conf/nginx.conf /etc/nginx/nginx.conf

COPY tools/index.html /data/www/index.html

COPY tools/entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/root/entrypoint.sh"]