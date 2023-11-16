#!/bin/bash
set -x

# (1) OpenSSH: Install
apt-get install -y --no-install-recommends openssh-client openssh-server
mkdir -p /var/run/sshd

# (2) OpenSSH: Allow Root login
sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g'  /etc/pam.d/sshd
sed -i 's/PermitRootLogin prohibit-password/#PermitRootLogin prohibit-password/'    /etc/ssh/sshd_config
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# (3) OpenSSH: Allow to talk to containers without asking for confirmation
cat /etc/ssh/ssh_config | grep -v StrictHostKeyChecking > /etc/ssh/ssh_config.new
echo "    StrictHostKeyChecking no" >> /etc/ssh/ssh_config.new
mv /etc/ssh/ssh_config.new /etc/ssh/ssh_config

# (4) OpenSSH: keygen
ssh-keygen -q -t rsa -N "" -f /root/.ssh/id_rsa
cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys
chmod 700 /root/.ssh

mkdir -p  /home/lab/.ssh
chmod 700 /home/lab/.ssh
ssh-keygen -q -t rsa -N "" -f /home/lab/.ssh/id_rsa
ssh-keygen -q -t dsa -N "" -f /home/lab/.ssh/id_dsa
cat /home/lab/.ssh/id_dsa.pub >> /home/lab/.ssh/authorized_keys
cat /home/lab/.ssh/id_rsa.pub >> /home/lab/.ssh/authorized_keys
chown -R lab:lab /home/lab/
chmod 700 /home/lab/.ssh

