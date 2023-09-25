#!/bin/bash

	# Remplace la ligne "listen = /run/php/php7.3-fpm.sock" par "listen = 9000" dans le fichier www.conf
	sed -i "s/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/" "/etc/php/7.3/fpm/pool.d/www.conf";

	# Change les propriétaires des fichiers dans /var/www/ au groupe et à l'utilisateur www-data
	chown -R www-data:www-data /var/www/*;

	# Donne les permissions 755 aux fichiers dans /var/www/
	chown -R 755 /var/www/*;

	# Crée le répertoire /run/php/ s'il n'existe pas
	mkdir -p /run/php/;

	# Crée un fichier vide /run/php/php7.3-fpm.pid s'il n'existe pas
	touch /run/php/php7.3-fpm.pid;

# Si le fichier wp-config.php n'existe pas, alors on va lancer l'installation de Wordpress
if [ ! -f /var/www/html/wp-config.php ]; then

	# Crée le répertoire s'il n'existe pas
	mkdir -p /var/www/html;

	# Télécharge et installe wp-cli
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;
	chmod +x wp-cli.phar; 
	mv wp-cli.phar /usr/local/bin/wp;

	cd /var/www/html;

	# Télécharge la version de base de Wordpress
	wp core download --allow-root;

	# Déplace le fichier wp-config dans /var/www/html
	mv /var/www/wp-config.php /var/www/html/wp-config.php;

	# Modifie les champs pour donner la valeur des variables d'environnement 
	sed -i "s/define( 'DB_NAME', 'SQL_DATABASE' );/define( 'DB_NAME', '${SQL_DATABASE}' );/" /var/www/html/wp-config.php;
	sed -i "s/define( 'DB_USER', 'SQL_USER' );/define( 'DB_USER', '${SQL_USER}' );/" /var/www/html/wp-config.php;
	sed -i "s/define( 'DB_PASSWORD', 'SQL_PASSWORD' );/define( 'DB_PASSWORD', '${SQL_PASSWORD}' );/" /var/www/html/wp-config.php;

	# Installe Wordpress avec les paramètres fournis
	wp core install --allow-root --url=${DOMAIN} --title=${WP_TITLE} --admin_user=${WP_ADMIN} --admin_password=${WP_ADMIN_PASSWORD};
	# Crée un nouvel utilisateur
	wp user create --allow-root ${WP_USER} --user_pass=${WP_USER_PASSWORD};
fi

exec "$@"