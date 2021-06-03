#! /bin/bash

debug()
{

echo pubkey is $(cat /root/.ssh/authorized_keys)
echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
echo "AuthorizedKeysFile	.ssh/authorized_keys .ssh/authorized_keys2" >> /etc/ssh/sshd_config
cat /etc/ssh/sshd_config
}

if [[ ! -z "$pubkey" ]]
then
echo "$pubkey" > $HOME/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
debug
else
echo pubkey is NOT set
env
fi

if [ -f /run/sshd ] 
then
   echo "/run/sshd exists"
else
   mkdir /run/sshd
fi

exec 2>&1 \
        s6-setuidgid root /usr/sbin/sshd -D -e 