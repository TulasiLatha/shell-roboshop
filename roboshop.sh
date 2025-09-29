#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-01d0099ea92b83c7f"

for instance in $@
do
     INSATNCE_ID=$(aws ec2 run-instances --image-id ami-09c813fb71547fc4f --instance-type t3.micro
      --security-group-ids sg-01d0099ea92b83c7f --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=Test}]'
       --query 'Instances[0].InstanceId' --output text)

       #get private id

       if [ $instance != "frontend" ]; then
             IP=$(aws ec2 describe-instances --instance-ids i-0168b8262dc2d1bd6 --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text)
       else
             IP=$(aws ec2 describe-instances --instance-ids i-0168b8262dc2d1bd6 --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)
        fi

        echo "$instance:$IP"
    done

