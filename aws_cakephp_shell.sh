# /bin/sh
sudo yum -y install php56 --skip-broken
sudo yum -y install php56-mbstring
sudo yum -y install php56-intl
sudo yum -y install mysql55-server php56-mysqlnd
sudo service httpd start
sudo chkconfig httpd on
sudo groupadd www
sudo usermod -a -G www ec2-user
sudo chown -R root:www /var/www
sudo chmod 2775 /var/www
find /var/www -type d -exec sudo chmod 2775 {} \;
sudo yum -y install git
sudo echo extension=pdo.so >> /etc/php.ini
cat <<EOT >> /etc/httpd/conf/httpd.conf
<Directory "/var/www/html/">
    Options FollowSymLinks
    AllowOverride All
</Directory>
EOT
sudo service httpd restart
sudo service mysqld start
sudo mysql_secure_installation
sudo chkconfig mysqld on
