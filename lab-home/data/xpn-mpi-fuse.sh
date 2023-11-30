#!/bin/bash
set -x


sudo chown lab:lab /shared

# 1) build configuration file /shared/config.xml
# 2) start mpi_servers in background
NL=$(cat /work/machines_mpi | wc -l)
UID=$(id -u)
GID=1000

NL=$(cat /work/machines_mpi | wc -l)
/home/lab/src/xpn/scripts/execute/xpn.sh -w /shared -l /work/machines_mpi -x /tmp/ -n $NL start

# 3) start FUSE
mpiexec -np $NL \
	-hostfile /work/machines_mpi \
        /home/lab/src/xpn/src/connector_fuse/fuse-expand /tmp/fuse -d -s -o xpnpart=/xpn -o big_writes -o no_remote_lock -o intr -o uid=$UID -o gid=$GID &
sleep 3

# 4) start xpn client
mpiexec -np 1 \
        -hostfile        /work/machines_mpi \
        -genv XPN_DNS    /shared/dns.txt  \
        -genv XPN_CONF   /shared/config.xml \
        /home/lab/src/xpn/test/integrity/bypass_c/open-write-close /tmp/fuse/test_1 10

# 5) stop mpi_servers
/home/lab/src/xpn/scripts/execute/xpn.sh -w /shared -d /work/machines_mpi stop

