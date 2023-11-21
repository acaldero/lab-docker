#!/bin/bash
set -x

sudo chown lab:lab /shared

/home/lab/src/xpn/scripts/execute//mk_conf.sh --conf        /shared/config.xml \
                                              --machinefile /work/export/names \
                                              --part_size   512k \
                                              --part_name   xpn \
                                              --storage_path /tmp/

mpiexec -np 3 \
	-hostfile /work/export/names \
	/home/lab/src/xpn/src/mpi_server/xpn_mpi_server -ns /shared/dns.txt &

sleep 3

mpiexec -np 3 \
        -hostfile      /work/export/names \
        -genv XPN_DNS  /shared/dns.txt  \
        -genv XPN_CONF /shared/config.xml \
        -genv LD_PRELOAD \
        ./bin/xpn/lib64/xpn_bypass.so:$LD_PRELOAD \
        /home/lab/src/xpn/test/integrity/xpn/open-write-close

mpiexec -np 1 \
        -genv XPN_DNS /shared/dns.txt \
        /home/lab/src/xpn/src/mpi_server/xpn_stop_mpi_server -f machinefile

