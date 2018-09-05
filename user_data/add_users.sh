#!/bin/bash -xe
######################################################################
# Add sudo group if it does not exist
getent group sudo > /dev/null || groupadd sudo

# Allow sudo group to become root without password
echo "%sudo ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-tf-ssh-bastion-sudo

# Add users if any
${data}
