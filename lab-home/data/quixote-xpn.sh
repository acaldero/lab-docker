#!/bin/bash
set -x


#
# (0) Set initial configuration
#

# source .profile first
if [[ -z "${PROFILE_LOADED}" ]]; then
  . .profile
fi

# configure workers (skip first for master)
tail -n +2 /work/machines_mpi > /home/lab/spark/conf/workers

sudo chown lab:lab /shared
rm -fr /shared/dns.txt

# build configuration file /shared/config.xml
/home/lab/src/xpn/scripts/execute/mk_conf.sh --conf         /shared/config.xml \
                                             --machinefile  /work/machines_mpi \
                                             --part_size    512k \
                                             --part_name    P1 \
                                             --storage_path /tmp/

#
# (1) Get data
#

# get local data
if [ ! -f /home/lab/data/2000-0.txt ]; then
     curl https://www.gutenberg.org/files/2000/2000-0.txt -o /home/lab/data/2000-0.txt
fi

# replication
./bin/replicate.sh /home/lab/spark/conf/workers /home/lab/data/2000-0.txt

# start mpi_servers in background
NL=$(cat /work/machines_mpi | wc -l)
mpiexec -np $NL \
        -hostfile /work/machines_mpi \
        /home/lab/src/xpn/src/mpi_server/xpn_mpi_server -ns /shared/dns.txt &

sleep 3

## copy data into XPN
export XPN_CONF=/shared/config.xml
export XPN_DNS=/shared/dns.txt
export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/libmxml.so:$LD_LIBRARY_PATH

# LD_PRELOAD=/home/lab/bin/xpn/lib/xpn_bypass.so:$LD_PRELOAD  cp  /home/lab/data/2000-0.txt  /tmp/expand/P1/2000-0.txt
#
# /home/lab/src/xpn/src/utils/cp-local2xpn /home/lab/data/2000-0.txt /P1/2000-0.txt


#
# (2) Run work
#

# clean
rm -fr /home/lab/data/2000-wc

# spark cluster
./spark/sbin/start-all.sh
sleep 2
LD_PRELOAD=/home/lab/bin/xpn/lib/xpn_bypass.so:$LD_PRELOAD  spark-submit /home/lab/data/quixote.py  --master "spark://nodo1:7077" --minput "/tmp/expand/P1/2000-0.txt" --moutput "/tmp/expand/P1/2000-wc"
sleep 2
./spark/sbin/stop-all.sh

# show results
LD_PRELOAD=/home/lab/bin/xpn/lib/xpn_bypass.so:$LD_PRELOAD  ls -als /tmp/expand/P1/2000-wc


#
# (3) stop mpi_servers
#
mpiexec -np 1 \
        -genv XPN_DNS /shared/dns.txt \
        /home/lab/src/xpn/src/mpi_server/xpn_stop_mpi_server -f /work/machines_mpi

