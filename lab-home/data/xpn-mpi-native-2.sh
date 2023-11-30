#!/bin/bash
set -x


sudo chown lab:lab /shared

NL=$(cat /work/machines_mpi | wc -l)
/home/lab/src/xpn/scripts/execute/xpn.sh -w /shared -l /work/machines_mpi -x /tmp/ -n $NL start

# 1) build configuration file /shared/config.xml
#/home/lab/src/xpn/scripts/execute/mk_conf.sh --conf         /shared/config.xml \
#                                             --machinefile  /work/machines_mpi \
#                                             --part_size    512k \
#                                             --part_name    xpn \
#                                             --storage_path /tmp/
#
# 2) start mpi_servers in background
#NL=$(cat /work/machines_mpi | wc -l)
#rm -fr /shared/dns.txt
#mpiexec -np $NL \
#	-hostfile /work/machines_mpi \
#	/home/lab/src/xpn/src/mpi_server/xpn_mpi_server -ns /shared/dns.txt &
#
#sleep 3

# 3) start xpn client
mpiexec -np 1 \
        -hostfile        /work/machines_mpi \
        -genv XPN_DNS    /shared/dns.txt  \
        -genv XPN_CONF   /shared/config.xml \
        /home/lab/src/xpn/test/performance/xpn/open-write-close /xpn/test 10

# 4) stop mpi_servers
/home/lab/src/xpn/scripts/execute/xpn.sh -w /shared -d /work/machines_mpi stop
#mpiexec -np 1 \
#        -genv XPN_DNS /shared/dns.txt \
#        /home/lab/src/xpn/src/mpi_server/xpn_stop_mpi_server -f /work/machines_mpi

