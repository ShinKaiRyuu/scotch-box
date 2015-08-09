#!/bin/sh

# PREPARE PHP

sudo apt-get remove -y php5 php5-*
sudo apt-get autoremove -y
sudo add-apt-repository --remove -y ppa:ondrej/php5-5.6
sudo add-apt-repository -y ppa:ondrej/php5
sudo apt-get -y update 
sudo apt-get install -y php5 php5-memcached php5-mysql libapache2-mod-php5 php5-mcrypt php5-curl php5-cli php5-pgsql php5-redis php5-common php5-json php5-readline

echo "extension=memcache.so" | sudo tee /etc/php5/apache2/conf.d/memcache.ini
sudo sed -i 's/short_open_tag = Off/short_open_tag = On/;' /etc/php5/apache2/php.ini

# SETUP APACHE
sudo service apache2 stop

# Remove all enabled VirtualHosts
sudo rm /etc/apache2/sites-enabled/*

# Copy apache config
sudo cp -fRv /vagrant/conf/apache2.conf /etc/apache2/apache2.conf

# Copy required VirtualHost files
sudo cp -fRv /vagrant/conf/sites-available/*.conf /etc/apache2/sites-available/

# Enable reqires VirtualHosts
sudo a2ensite default.conf

sudo service apache2 start

# Setup OnePlayce
## Composer
# sudo composer config -g github-oauth.github.com 04027f4c258ffc4c37266bc853508674ee30f5d0
# sudo composer global require "fxp/composer-asset-plugin:1.0.1"
# sudo composer install --prefer-dist --no-interaction --working-dir /var/sites/oneplayce
# ## Database
# cat /vagrant/database/OnePlayce.sql | mysql -uroot -proot
# sudo cp -n /var/sites/oneplayce/config/db-local-sample.php /var/sites/oneplayce/config/db-local.php
# sed -i 's/db_name/oneplayce/;s/db_user/oneplayceu/;s/db_pass/oneplaycep/' /var/sites/oneplayce/config/db-local.php