#!/bin/bash
ask_yes_no() {
    while true; do
        read -p "$1 (Y/N): " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "";;
        esac
    done
}

if [ -e "./key/authorized_keys" ]; then
    if ask_yes_no "Are you sure to overwrite old files?"; then 
        rm ./key/authorized_keys
        rm ./key/id_rsa
    else
        exit 0
    fi
fi

set -x
mkdir key -p
ssh-keygen -f key/id_rsa -t rsa
chmod 600 key/id_rsa.pub
chmod 600 key/id_rsa
mv key/id_rsa.pub key/authorized_keys