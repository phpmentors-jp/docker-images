#!/bin/bash

function _php_timezone_configure() {
    if [ $# -lt 1 ]; then
        echo 'Usage: _php_timezone_configure <timezone>'

        return 1
    fi

    local timezone="$1"
    local timezone_file="/usr/share/zoneinfo/${timezone}"

    if [ ! -e $timezone_file ]; then
        echo "ERROR: \"$timezone_file\" does not exist."

        return 1
    fi

    echo "date.timezone=$timezone" >> /etc/php5/apache2/conf.d/90-app.ini
    RETVAL=$?
    if [ $RETVAL -ne 0 ]; then
        return $RETVAL
    fi

    echo "date.timezone=$timezone" >> /etc/php5/cli/conf.d/90-app.ini
    RETVAL=$?
    if [ $RETVAL -ne 0 ]; then
        return $RETVAL
    fi

    return 0
}
