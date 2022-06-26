#!/bin/bash

NonSudo_E=101
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'

[[ $UID -eq 0 ]] || {
        echo "You do not have permission to run this script"
        exit $NonSudo_E
}

#AWS Credentials gettimg from AWS parameter store
AWS_ACCESS_KEY_ID=$(aws --region=us-east-1 ssm get-parameter --name "MY_ACCESS_KEY" --with-decryption --output text --query Parameter.Value)
AWS_SECRET_ACCESS_KEY=$(aws --region=us-east-1 ssm get-parameter --name "MY_SECRET_KEY" --with-decryption --output text --query Parameter.Value)
AWS_DEFAULT_REGION=us-east-1

#EC2 DETAILS
AMI="ami-09d56f8956ab235b3"
COUNT=1
INSTANCE_TYPE="t2.micro"
KEY_NAME="assignment-02-kp"
SUBNET_ID="subnet-0cdeae960f2b5f821"
TAG='ResourceType=instance,Tags=[{Key=Name,Value=ubuntu-server-01}]'
SG="sg-06e774acf855ee26d"

#EC2 DETAILS
SUBNET_ID2="subnet-0d57e59e37597dd98"
TAG2='ResourceType=instance,Tags=[{Key=Name,Value=ubuntu-server-02}]'

source task_04.sh

aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
aws configure set default.region $AWS_DEFAULT_REGION

echo "Launching EC2...."
aws ec2 run-instances \
        --image-id $AMI \
        --count $COUNT \
        --instance-type $INSTANCE_TYPE \
        --key-name $KEY_NAME \
        --security-group-ids $SG \
        --subnet-id $SUBNET_ID \
        --tag-specifications $TAG \

aws ec2 run-instances \
        --image-id $AMI \
        --count $COUNT \
        --instance-type $INSTANCE_TYPE \
        --key-name $KEY_NAME \
        --security-group-ids $SG \
        --subnet-id $SUBNET_ID2 \
        --tag-specifications $TAG2 \