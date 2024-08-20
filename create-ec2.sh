#!/bin/bash

NAMES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "cart" "user" "shipping" "payment" "dispatch" "web")

for i in "${NAMES[@]}"
do 
    echo "NAME: $i"
done


