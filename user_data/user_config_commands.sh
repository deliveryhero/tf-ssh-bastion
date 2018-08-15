
echo "#### Creating user ${username}"
useradd ${username} --create-home --groups ${group} --shell /bin/bash
mkdir ~${username}/.ssh
echo "${key}" > ~${username}/.ssh/authorized_keys
chown -R ${username}: ~${username}/.ssh
chmod 0600 ~${username}/.ssh/authorized_keys
