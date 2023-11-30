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


#
# (1) Start mpi_servers in background
#

sudo chown lab:lab /shared
NL=$(cat /work/machines_mpi | wc -l)
/home/lab/src/xpn/scripts/execute/xpn.sh -w /shared -l /work/machines_mpi -x /tmp/ -n $NL start


#
# (2) Get data
#

# get local data
if [ ! -f /home/lab/data/2000-0.txt ]; then
     curl https://www.gutenberg.org/files/2000/2000-0.txt -o /home/lab/data/2000-0.txt
fi

# replication
./bin/replicate.sh /home/lab/spark/conf/workers /home/lab/data/2000-0.txt

# copy data into XPN
export XPN_CONF=/shared/config.xml
export XPN_DNS=/shared/dns.txt
export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/libmxml.so:$LD_LIBRARY_PATH
#
# LD_PRELOAD=/home/lab/bin/xpn/lib/xpn_bypass.so:$LD_PRELOAD  cp  /home/lab/data/2000-0.txt  /tmp/expand/xpn/2000-0.txt
# /home/lab/src/xpn/src/utils/cp-local2xpn /home/lab/data/2000-0.txt /xpn/2000-0.txt


#
# (3) Run work
#

# clean
rm -fr /home/lab/data/2000-wc

# spark cluster
./spark/sbin/start-all.sh
sleep 2
LD_PRELOAD=/home/lab/bin/xpn/lib/xpn_bypass.so:$LD_PRELOAD  spark-submit /home/lab/data/quixote.py  --master "spark://nodo1:7077" --minput "/tmp/expand/xpn/2000-0.txt" --moutput "/tmp/expand/xpn/2000-wc"
sleep 2
./spark/sbin/stop-all.sh

# show results
LD_PRELOAD=/home/lab/bin/xpn/lib/xpn_bypass.so:$LD_PRELOAD  ls -als /tmp/expand/xpn/2000-wc


#
# (4) stop mpi_servers
#
/home/lab/src/xpn/scripts/execute/xpn.sh -w /shared -d /work/machines_mpi stop

