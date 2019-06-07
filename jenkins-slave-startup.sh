#!/bin/bash

set -ex


# start the docker daemon
/usr/local/bin/wrapdocker &

# start the ssh daemon
mkdir -p -m0755 /var/run/sshd && systemctl restart sshd.service
/usr/sbin/sshd -D