#!/bin/bash

#AWS Credentials
AWS_ACCESS_KEY_ID=AKIA3JV25H7SOVYCKAE6
AWS_SECRET_ACCESS_KEY=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
AWS_DEFAULT_REGION=us-east-1

#EC2 DETAILS
AMI="ami-09d56f8956ab235b3"
COUNT=1
INSTANCE_TYPE="t2.micro"
KEY_NAME="assignment-02-kp"
SUBNET_ID="subnet-0a255047a56bb5773"
TAG='ResourceType=instance,Tags=[{Key=Name,Value=website-server}]'
SG="sg-06e774acf855ee26d"

NonSudo_E=101

[[ $UID -eq 0 ]] || {
        echo "You do not have permission to run this script"
        exit $NonSudo_E
}

source task_03.sh

aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
aws configure set default.region $AWS_DEFAULT_REGION


aws ec2 run-instances \
        --image-id $AMI \
        --count $COUNT \
        --instance-type $INSTANCE_TYPE \
        --key-name $KEY_NAME \
        --security-group-ids $SG \
        --subnet-id $SUBNET_ID \
        --tag-specifications $TAG \
        --user-data file://userdata.txt

