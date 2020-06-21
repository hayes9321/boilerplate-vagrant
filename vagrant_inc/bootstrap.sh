#!/bin/bash

### Point Nginx to the web root
sudo cp -f /vagrant_data/nginx-default-site /etc/nginx/sites-available/default
sudo ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
sudo service nginx restart

sudo cp -f /vagrant_data/www.conf /etc/php/7.3/fpm/pool.d/www.conf
sudo update-alternatives --set php /usr/bin/php7.3
sudo service php5.6-fpm stop
sudo service php7.1-fpm stop
sudo service php7.2-fpm stop
sudo service php7.3-fpm start

sudo cp -f /vagrant_data/.env /var/www/html
sudo cp -f /vagrant_data/app.php /var/www/html/config
