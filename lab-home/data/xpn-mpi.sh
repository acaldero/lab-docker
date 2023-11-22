#!/bin/bash
set -x


sudo chown lab:lab /shared
rm -fr /shared/dns.txt

# 1) build configuration file /shared/config.xml
/home/lab/src/xpn/scripts/execute/mk_conf.sh --conf         /shared/config.xml \
                                             --machinefile  /work/machines_hosts \
                                             --part_size    512k \
                                             --part_name    xpn \
                                             --storage_path /tmp/

# 2) start mpi_servers in background
mpiexec -np 3 \
	-hostfile /work/machines_hosts \
	/home/lab/src/xpn/src/mpi_server/xpn_mpi_server -ns /shared/dns.txt &

sleep 3

# 3) start mpi client
mpiexec -np 3 \
        -hostfile        /work/machines_hosts \
        -genv XPN_DNS    /shared/dns.txt  \
        -genv XPN_CONF   /shared/config.xml \
        -genv LD_PRELOAD /home/lab/bin/xpn/lib64/xpn_bypass.so:$LD_PRELOAD \
        /home/lab/src/xpn/test/integrity/xpn/open-write-close


# 4) stop mpi_servers
mpiexec -np 1 \
        -genv XPN_DNS /shared/dns.txt \
        /home/lab/src/xpn/src/mpi_server/xpn_stop_mpi_server -f /work/machines_hosts

