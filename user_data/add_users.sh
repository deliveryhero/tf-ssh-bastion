#!/bin/bash -xe
######################################################################
# Allow sudo group to become room without password
echo "%sudo ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-tf-ssh-bastion-sudo

# Add users if any
${data}
