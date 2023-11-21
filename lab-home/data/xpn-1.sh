#!/bin/bash
set -x

/home/lab/src/xpn/scripts/execute//mk_conf.sh --conf        /tmp/config.xml \
                                              --machinefile /work/export/names \
                                              --part_size   512k \
                                              --part_name   xpn \
                                              --storage_path /tmp/

scp /tmp/dns.txt    nodo2:/tmp
scp /tmp/dns.txt    nodo3:/tmp
scp /tmp/config.xml nodo3:/tmp
scp /tmp/config.xml nodo2:/tmp

mpiexec -np 3 \
	-hostfile /work/export/names \
	/home/lab/src/xpn/src/mpi_server/xpn_mpi_server -ns /tmp/dns.txt &

sleep 3

mpiexec -np 3 \
        -hostfile /work/export/names \
        -genv XPN_DNS  /tmp/dns.txt  \
        -genv XPN_CONF /tmp/config.xml \
        -genv LD_PRELOAD \
        ./bin/xpn/lib64/xpn_bypass.so:$LD_PRELOAD \
        /home/lab/src/xpn/test/integrity/xpn/open-write-close

mpiexec -np 1 \
        -genv XPN_DNS /tmp//dns.txt \
        /home/lab/src/xpn/src/mpi_server/xpn_stop_mpi_server -f machinefile

