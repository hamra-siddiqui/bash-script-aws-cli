#!/bin/bash

NonSudo_E=101

[[ $UID -eq 0 ]] || {
        echo "You do not have permission to run this script"
        exit $NonSudo_E
}

source task_02.sh

nginx_status='Dead'
file://index.html
rm -rf /var/www/html/*

systemctl status nginx
if [[ $? -eq 0 ]]
then
    NGINX_STATUS='Active'
fi

    Student="Hamra Tariq"
    nginx_V=$(nginx -v 2>&1 | awk -F' ' '{print $3}' | cut -d / -f 2)
    aws_V=$(aws --version | awk '{print $1}' | tr '/' ' ' | awk '{print $2}')
    EC2_count=$(aws ec2 describe-instances --filter 'Name=instance-state-name,Values=running' --query 'Reservations[*].Instances[*].[InstanceId]' --output text | wc -l)
    SG_count=$(aws ec2 describe-security-groups --query "SecurityGroups[*].{Name:GroupName}"  --output text | wc -l)

    sed -i "s/STUDENTNAME/$Student/g" $PWD/index.html
    sed -i "s/NGINXSTATUS/$nginx_status/g" $PWD/index.html
    sed -i "s/NGINXVERSION/$nginx_V/g" $PWD/index.html
    sed -i "s/VERSIONAWS/$aws_V/g" $PWD/index.html
    sed -i "s/EC2COUNT/$EC2_count/g" $PWD/index.html
    sed -i "s/SECGRPCOUNT/$SG_count/g" $PWD/index.html

    echo 'Successfully updated index.html file to nginx'

    mv $PWD/index.html /var/www/html/


