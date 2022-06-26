#!/bin/bash

NonSudo_E=101
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'

[[ $UID -eq 0 ]] || {
        echo "You do not have permission to run this script"
        exit $NonSudo_E
}
which aws &> /dev/null

if [[ $? -ne 0 ]]
then
        echo "aws-cli not installed"
        ver=`uname -m`

        if [[ $ver = 'x86_64' ]]
        then
                echo "ver: ${ver}"
                echo "Installing aws-cli for x86 machine"
                curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
                unzip awscliv2.zip
                sudo ./aws/install -y $> /dev//null
                rm $PWD/awscliv2.zip
        else
                echo "ver: ${ver}"
                if [[ $ver -ne 'ARM' ]]
                then
                        echo "Installing aws-cli for ARM machine"
                        curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
                        unzip awscliv2.zip
                        sudo ./aws/install -y $> /dev//null
                        rm $PWD/awscliv2.zip
                fi
        fi


else
        echo "aws-cli 2.7.9 is already installed in your machine"
fi

