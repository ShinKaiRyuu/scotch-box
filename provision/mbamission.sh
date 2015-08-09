#!/bin/sh

# Create database 
cat /vagrant/database/score_mbamission.sql | mysql -uroot -proot

# Update config.properties
sudo sed -i 's/mbamission.log.path=.*/mbamission.log.path=\/var\/sites\/scoreboard\/mbamission\/logs\//;' /var/sites/scoreboard/properties/config.properties
sudo sed -i 's/mbamission.server.path=.*/mbamission.server.path=\/var\/sites\/scoreboard\/mbamission\/ui/;' /var/sites/scoreboard/properties/config.properties
sudo sed -i 's/mbamission.class.path=.*/mbamission.class.path=\/var\/sites\/scoreboard\//;' /var/sites/scoreboard/properties/config.properties
sudo sed -i 's/mbamission.db=.*/mbamission.db=VAGRANT/;' /var/sites/scoreboard/properties/config.properties
sudo sed -i 's/mbamission.memcache=.*/mbamission.memcache=VAGRANT/;' /var/sites/scoreboard/properties/config.properties

# Update Config.class
sudo sed -i 's/vg_db_name/score_mbamission/;s/vg_db_user/score/;s/vg_db_pass/password/;' /var/sites/scoreboard/mbamission/config/Config.class

# Import database
unzip /var/sites/scoreboard/tools/travis/score.zip
mysql -uroot -proot score_mbamission < score.sql
sudo rm score.sql

# Copy VirtualHost
sudo cp -fRv /vagrant/conf/sites-available/mbamission.conf /etc/apache2/sites-available/

# Enable VirtualHost
sudo a2ensite mbamission.conf

sudo service apache2 reload