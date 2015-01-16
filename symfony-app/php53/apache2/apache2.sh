#!/bin/bash

if [ "x$APP_PHP_INI" != "x" ]; then
    echo "$APP_PHP_INI" | grep "^\/" 
    RETVAL=$?
    if [ $RETVAL -ne 0 ]; then
        APP_PHP_INI="/var/app/${APP_PHP_INI}"
    fi

    if [ -e "$APP_PHP_INI" ]; then
        ln -sf "$APP_PHP_INI" /etc/php5/apache2/conf.d/99-app.ini
        ln -sf "$APP_PHP_INI" /etc/php5/cli/conf.d/99-app.ini
    fi
fi

if [ "x$APP_XDEBUG_REMOTE_PORT" != "x" ]; then
    sed -i "s/^ *\\(xdebug\\.remote_port\\) *= *.*/\\1=${APP_XDEBUG_REMOTE_PORT}/" /etc/php5/apache2/conf.d/90-app.ini
    sed -i "s/^ *\\(xdebug\\.remote_port\\) *= *.*/\\1=${APP_XDEBUG_REMOTE_PORT}/" /etc/php5/cli/conf.d/90-app.ini
fi


source /etc/apache2/envvars && exec /usr/sbin/apache2 -D FOREGROUND
