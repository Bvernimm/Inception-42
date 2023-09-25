FROM debian:buster

RUN apt-get update 
RUN apt-get install -y mariadb-server

EXPOSE 3306

# MariaDB config
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

# MySQL setup
COPY ./tools /var/www/
RUN chmod +x /var/www/MySQL.sh;

CMD ["/var/www/MySQL.sh"]