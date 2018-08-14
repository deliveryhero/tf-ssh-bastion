#!/bin/bash -xe
######################################################################
echo "#### Running setup_init.sh"
######################################################################
echo "#### Setting up repos and software"
apt-get update
apt-get install --force-yes -y python-pip python-setuptools awscli
pip install --upgrade pip
######################################################################
echo "#### AWS user-data execution complete"
