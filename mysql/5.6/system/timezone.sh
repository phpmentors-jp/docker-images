#!/bin/bash

function _system_timezone_configure() {
    if [ $# -lt 1 ]; then
        echo 'Usage: _system_timezone_configure <timezone>'

        return 1
    fi

    local timezone="$1"
    local timezone_file="/usr/share/zoneinfo/${timezone}"

    if [ ! -e $timezone_file ]; then
        echo "ERROR: \"$timezone_file\" does not exist."

        return 1
    fi

    echo "$timezone" > /etc/timezone
    RETVAL=$?
    if [ $RETVAL -ne 0 ]; then
        return $RETVAL
    fi

    dpkg-reconfigure -f noninteractive tzdata
    RETVAL=$?
    if [ $RETVAL -ne 0 ]; then
        return $RETVAL
    fi

    return 0
}
