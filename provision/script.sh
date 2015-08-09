#!/bin/sh

# PREPARE PHP

sudo apt-get remove -y php5 php5-*
sudo apt-get autoremove -y
sudo add-apt-repository --remove -y ppa:ondrej/php5-5.6
sudo add-apt-repository -y ppa:ondrej/php5
sudo apt-get update -y
sudo apt-get install -y memcached unzip
sudo apt-get install -y php5 libapache2-mod-php5 php-pear php5 php5-cgi php5-cli php5-common php5-curl php5-fpm php5-gd php5-imagick php5-intl php5-json php5-mcrypt php5-memcache php5-memcached php5-mysql php5-pgsql php5-readline php5-redis php5-sqlite

echo "extension=memcache.so" | sudo tee /etc/php5/apache2/conf.d/memcache.ini
sudo sed -i 's/short_open_tag = Off/short_open_tag = On/;' /etc/php5/apache2/php.ini

# SETUP APACHE
sudo service apache2 stop

# Remove all enabled VirtualHosts
sudo rm /etc/apache2/sites-enabled/*

# Copy apache config
sudo cp -fRv /vagrant/conf/apache2.conf /etc/apache2/apache2.conf

# Copy required VirtualHost files
sudo cp -fRv /vagrant/conf/sites-available/default.conf /etc/apache2/sites-available/

# Enable reqires VirtualHosts
sudo a2ensite default.conf

sudo service apache2 start