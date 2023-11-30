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
# (1) Get data
#

# get local data
if [ ! -f /home/lab/data/2000-0.txt ]; then
     curl https://www.gutenberg.org/files/2000/2000-0.txt -o /home/lab/data/2000-0.txt
fi

# replication
./bin/replicate.sh /home/lab/spark/conf/workers /home/lab/data/2000-0.txt


#
# (2) Run work
#

# clean
rm -fr /home/lab/data/2000-wc

# spark cluster
./spark/sbin/start-all.sh
sleep 2
spark-submit /home/lab/data/quixote.py --master "spark://nodo1:7077" --minput "/home/lab/data/2000-0.txt" --moutput "/home/lab/data/2000-wc"
sleep 2
./spark/sbin/stop-all.sh

# show results
ls -als /home/lab/data/2000-wc

