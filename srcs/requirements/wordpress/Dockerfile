FROM debian:buster

RUN apt-get update
RUN apt-get install -y php7.3
RUN apt-get install -y php-mysqli
RUN apt-get install -y php-fpm
RUN apt-get install -y wget

EXPOSE 9000

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d
COPY ./tools /var/www/

RUN chmod +x /var/www/wordpress_start.sh

ENTRYPOINT [ "/var/www/wordpress_start.sh" ]

CMD ["/usr/sbin/php-fpm7.3", "--nodaemonize"]