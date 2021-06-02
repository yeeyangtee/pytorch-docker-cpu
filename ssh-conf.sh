#! /bin/bash

echo "$pubkey" > /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
