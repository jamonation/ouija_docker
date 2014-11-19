#!/bin/bash

DEBIAN_FRONTEND=noninteractive
dpkg-reconfigure --no mysql-server-5.5
/usr/sbin/service mysql start
printf "\033[1mSetting MySQL permissions and importing schema\033[m\n"
mysql -u root -e "CREATE DATABASE IF NOT EXISTS ouija;"
mysql -u root -e "GRANT ALL on ouija.* to ouija_user@'%';"
bzcat /var/lib/mysql/ouija.sql.bz2 |mysql -u ouija_user ouija
exit
