#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
apt update
apt install apache2
apt install ufw
apt install -y xdg-utils
ufw status verbose
ufw enable
ufw default deny incoming
ufw default allow outgoing
ufw allow 80/tcp
ufw allow from 127.0.0.1
ufw status
if [ ! -d "/var/www/marianpetlovanyi/" ]; then
	mkdir /var/www/marianpetlovanyi/
fi
touch /var/www/marianpetlovanyi/index.html
echo '<html><html><body><h1>Marian Petlovanyi</h1></body></html>' > /var/www/marianpetlovanyi/index.html
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/marianpetlovanyi.conf
sh -c "echo '<VirtualHost *:80>\n\tServerAdmin petlyovanyy@gmail.com \n\tDocumentRoot /var/www/marianpetlovanyi \n\tServerName marianpetlovanyi.example.com \n\tErrorLog ${APACHE_LOG_DIR}/error.log \n\tCustomLog ${APACHE_LOG_DIR}/access.log combined \n</VirtualHost>' > /etc/apache2/sites-available/marianpetlovanyi.conf"
a2ensite marianpetlovanyi.conf
sh -c "echo '127.0.0.1 marianpetlovanyi.example.com' >> /etc/hosts"
service apache2 restart
systemctl reload apache2
