#!/bin/bash

# Vérifie si un certificat nginx existe, si pas le crée
if [ ! -f /etc/ssl/certs/nginx.crt ]; then
	mkdir /etc/nginx/ssl
	# Génère un certificat auto-signé avec openssl
	openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    	    -out /etc/nginx/ssl/bvernimm.pem \
    	    -keyout /etc/nginx/ssl/bvernimm.key \
    	    -subj "/C=BE/ST=Bruxelles/L=Bruxelles/O=42 School/OU=bvernimm/CN=bvernimm/"
fi

exec "$@"