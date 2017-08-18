#!/bin/bash

function _system_locale_configure() {
    if [ $# -lt 1 ]; then
        echo 'Usage: _system_locale_configure <lang>'

        return 1
    fi

    local lang="$1"
    local lang_package_suffix=`echo $lang | grep -o '^[a-z]\+'`

    apt-get install -y "language-pack-${lang_package_suffix}"
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
