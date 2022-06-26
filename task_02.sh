#!/bin/bash

NonSudo_E=101
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'

[[ $UID -eq 0 ]] || {
        echo "You do not have permission to run this script"
        exit $NonSudo_E
}
systemctl status nginx
if [[ $? -eq 0 ]]
then
        echo -e "${GREEN}NGINX is Running ${NC}"

else
        echo -e "${RED}NGINX is Dead. Do you want to run NGINX [y/n]? ${NC}"
        read  ANS
        echo "ANS: ${ANS}"
        if [[ $ANS = 'y' ]]
        then
                systemctl start nginx
                if [[ $? -ne 0 ]]
                then
                        echo -e "${RED}Something went wrong, NGINX cannot be activated${NC}"
                else
                        echo "NGINX started successfully"
                fi
        else
                echo "Exiting"
        fi
fi



