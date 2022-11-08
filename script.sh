#!/bin/bash
sudo apt update
sudo apt install apache2
sudo apt install ufw
sudo ufw status verbose
sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 80/tcp
sudo ufw allow from 127.0.0.1
sudo ufw status
sudo mkdir /var/www/marianpetlovanyi/
sudo touch /var/www/marianpetlovanyi/index.html
sudo sh -c "echo '<html><html><body><h1>Marian Petlovanyi</h1></body></html>' > /var/www/marianpetlovanyi/index.html"
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/marianpetlovanyi.conf
sudo sh -c "echo '<VirtualHost *:80>\n\tServerAdmin petlyovanyy@gmail.com \n\tDocumentRoot /var/www/marianpetlovanyi \n\tServerName marianpetlovanyi.example.com \n\tErrorLog ${APACHE_LOG_DIR}/error.log \n\tCustomLog ${APACHE_LOG_DIR}/access.log combined \n</VirtualHost>' > /etc/apache2/sites-available/marianpetlovanyi.conf"
sudo a2ensite marianpetlovanyi.conf
sudo sh -c "echo '127.0.0.1 marianpetlovanyi.example.com' >> /etc/hosts"
sudo service apache2 restart
sudo systemctl reload apache2
firefox marianpetlovanyi.example.com







