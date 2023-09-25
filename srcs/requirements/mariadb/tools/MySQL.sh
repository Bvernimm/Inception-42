#!/bin/bash

echo "MariaDB Setup";

# Modifie les champs pour donner la valeur des variables d'environnement
sed -i "s/SQL_DATABASE/${SQL_DATABASE}/" /var/www/initial_db.sql;
sed -i "s/SQL_USER/${SQL_USER}/" /var/www/initial_db.sql;
sed -i "s/SQL_PASSWORD/${SQL_PASSWORD}/" /var/www/initial_db.sql;

# echo "${SQL_DATABASE} est ok avec ${SQL_USER} et ${SQL_PASSWORD}";

# Lance MySQL
exec mysqld_safe --init-file=/var/www/initial_db.sql