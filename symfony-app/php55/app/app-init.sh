#!/bin/bash

application_dir="/var/app"

parameters_file="${application_dir}/app/config/parameters.yml"
database_driver="pdo_mysql"
database_host="$MYSQL_PORT_3306_TCP_ADDR"
database_port="$MYSQL_PORT_3306_TCP_PORT"
database_user="root"
database_password="$MYSQL_ENV_MYSQL_ROOT_PASSWORD"
secret=`apg -a 1 -M nl -n 1 -m 40 -E ghijklmnopqrstuvwxyz`

COMPOSER_CACHE_DIR="${application_dir}/.composer"

if [ "x$APACHE_RUN_USER" = "x" ]; then
    echo "ERROR: The environment variable \"APACHE_RUN_USER\" does not exist."

    exit 1
fi

if [ ! -d "$application_dir" ]; then
    echo "ERROR: \"$application_dir\" does not exist. Mount your Symfony project root as \"$application_dir\" on the host."

    exit 1
fi

cd "$application_dir"

find "${application_dir}" ! -group $APACHE_RUN_GROUP -exec chgrp $APACHE_RUN_GROUP '{}' \;
find "${application_dir}" -type d ! -perm 2775 -exec chmod 2775 '{}' \;
find "${application_dir}" -type f ! -perm -g=w -exec chmod g+w '{}' \;

if [ ! -e "${application_dir}/composer.phar" ]; then
    sudo -u $APACHE_RUN_USER php -r "readfile('https://getcomposer.org/installer');" | sudo -u $APACHE_RUN_USER php
fi

if [ -e "${application_dir}/composer.phar" ]; then
    sudo -u $APACHE_RUN_USER COMPOSER_HOME="${application_dir}/.composer" php composer.phar self-update
    sudo -u $APACHE_RUN_USER COMPOSER_HOME="${application_dir}/.composer" php composer.phar install --no-interaction
fi

if [ -e "${application_dir}/composer.phar" ]; then
    sudo -u $APACHE_RUN_USER COMPOSER_HOME="${application_dir}/.composer" php composer.phar install --no-interaction
fi

find "${application_dir}" ! -group $APACHE_RUN_GROUP -exec chgrp $APACHE_RUN_GROUP '{}' \;
find "${application_dir}" -type d ! -perm 2775 -exec chmod 2775 '{}' \;
find "${application_dir}" -type f ! -perm -g=w -exec chmod g+w '{}' \;

sed -i "s/^\\( *database_driver:\\).*/\\1 ${database_driver}/" "$parameters_file"
sed -i "s/^\\( *database_host:\\).*/\\1 ${database_host}/" "$parameters_file"
sed -i "s/^\\( *database_port:\\).*/\\1 ${database_port}/" "$parameters_file"
sed -i "s/^\\( *database_user:\\).*/\\1 ${database_user}/" "$parameters_file"
sed -i "s/^\\( *database_password:\\).*/\\1 ${database_password}/" "$parameters_file"
sed -i "s/^\\( *secret:\\).*/\\1 ${secret}/" "$parameters_file"
