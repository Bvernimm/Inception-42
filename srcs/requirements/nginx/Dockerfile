FROM debian:buster

RUN apt-get update
RUN apt-get install -y nginx
RUN apt-get install -y openssl

EXPOSE 443

COPY ./conf/default /etc/nginx/sites-enabled/default
COPY ./tools/start.sh /var/www

RUN chmod +x /var/www/start.sh

ENTRYPOINT [ "var/www/start.sh" ]

CMD ["nginx", "-g", "daemon off;"]
