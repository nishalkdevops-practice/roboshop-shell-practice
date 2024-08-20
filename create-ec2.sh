#!/bin/bash

NAMES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "cart" "user" "shipping" "payment" "dispatch" "web")
INSTANCE_TYPE=""
IMAGE_ID=ami-0b4f379183e5706b9
SECURITY_GROUP_ID=sg-034b8c610c8a714d3


for i in "${NAMES[@]}"
do 
    if [[ $i == "mongodb" || $i == "mysql" ]]
    then
        INSTANCE_TYPE="t3.medium"
    else
        INSTANCE_TYPE="t2.micro"
    fi 

    echo "creating $i instance"
    aws ec2 run-instances --image-id $IMAGE_ID  --instance-type $INSTANCE_TYPE  --security-group-ids $SECURITY_GROUP_ID --tag-specifications "ResourceType=instance, Tags=[{Key=Name, Value=$i}]" | jq -r '.Instance[0].PrivateIpAddress'

done


