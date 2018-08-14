#!/bin/bash -xe
######################################################################
echo "#### Running assocaite_eip.sh"
######################################################################
# This script associates an Elastic IP with an instance.
######################################################################
echo "#### Setting important variables"
INSTANCE_ID=$(wget -q -O - http://169.254.169.254/latest/meta-data/instance-id)
AWS_EC2_AZ=$(wget -q -O - http://169.254.169.254/latest/meta-data/placement/availability-zone)
AWS_REGION="$${AWS_EC2_AZ::-1}"
######################################################################
aws ec2 associate-address --region "$${AWS_REGION}" --instance-id "$${INSTANCE_ID}" --allocation-id "${EIP_ALLOCATION_ID}"
