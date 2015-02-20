#!/bin/bash

. /usr/local/sbin/system-locale.sh
. /usr/local/sbin/system-timezone.sh

if [ "x$LANG" != "x" ]; then
    _system_locale_configure "$LANG"
fi

if [ "x$TZ" != "x" ]; then
    _system_timezone_configure "$TZ"
fi

if [ -z "$(ls -A /var/lib/mysql)" -a "${1%_safe}" = 'mysqld' ]; then
    if [ "x$MYSQL_CHARACTER_SET" != "x" ]; then
        sed -i "s/^\\( *character_set_server\\) *= *.*/\\1 = ${MYSQL_CHARACTER_SET}/" /etc/mysql/conf.d/characterset.cnf
        sed -i "s/^\\( *default-character-set\\) *= *.*/\\1 = ${MYSQL_CHARACTER_SET}/" /etc/mysql/conf.d/characterset.cnf
    fi
fi
