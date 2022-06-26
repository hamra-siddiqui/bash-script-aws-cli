#!/bin/bash

NonSudo_E=101

[[ $UID -eq 0 ]] || {
        echo "You do not have permission to run this script"
        exit $NonSudo_E
}
which nginx
if [[ $? -eq 0 ]]
then
        echo "NGINX is installed"
        apt upgrade nginx -y
        nginx -v
else
        echo "Installing NGINX!"
        apt install nginx -y
        echo "NGINX installed successfully"
fi






