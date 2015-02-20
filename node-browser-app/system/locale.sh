#!/bin/bash

function _node_browser_app_system_locale_configure() {
    if [ $# -lt 1 ]; then
        echo 'Usage: _node_browser_app_system_locale_configure <lang>'

        return 1
    fi

    local lang="$1"

    grep "$lang" /etc/locale.gen
    RETVAL=$?
    if [ $RETVAL -ne 0 ]; then
        echo "ERROR: \"$lang\" does not exist."

        return $RETVAL
    fi

    sed -i "s/# *\($lang\)/\\1/" /etc/locale.gen
    RETVAL=$?
    if [ $RETVAL -ne 0 ]; then
        return $RETVAL
    fi

    locale-gen
    RETVAL=$?
    if [ $RETVAL -ne 0 ]; then
        return $RETVAL
    fi

    update-locale LANG="$lang"
    RETVAL=$?
    if [ $RETVAL -ne 0 ]; then
        return $RETVAL
    fi

    export LANG="$lang"
    export LANGUAGE="$lang"

    return 0
}
