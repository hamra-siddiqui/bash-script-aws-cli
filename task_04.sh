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
echo $AWS_ACCESS_KEY_ID
echo $AWS_SECRET_ACCESS_KEY

AWS_DEFAULT_REGION=us-east-1

aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
aws configure set default.region $AWS_DEFAULT_REGION




