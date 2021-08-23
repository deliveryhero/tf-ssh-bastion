#!/bin/bash -xe
######################################################################
echo "#### Running setup_init.sh"
######################################################################
echo "#### Setting up repos and software"
export DEBIAN_FRONTEND=noninteractive
apt-get update
# as python 2 is deprecated in focal release (20.04 LTS) of ubuntu
apt-get install --force-yes -y python3-pip python3-setuptools awscli
# pip3 and pip point to the same binary for 20.04
pip install --upgrade pip
######################################################################
echo "#### Setting hostname"
hostnamectl set-hostname "${INSTANCE_HOSTNAME}"
echo "127.0.0.1 ${INSTANCE_HOSTNAME}" >> /etc/hosts
######################################################################
echo "#### AWS user-data execution complete"
