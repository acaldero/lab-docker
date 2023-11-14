#!/bin/bash
set -x


#
# (1) Data
#

# get local data
if [ ! -f /home/lab/data/2000-0.txt ]; then
     curl https://www.gutenberg.org/files/2000/2000-0.txt -o /home/lab/data/2000-0.txt
fi

# replication
tail -n +2 /work/export/names > /home/lab/spark/conf/workers

LIST=$(cat /home/lab/spark/conf/workers)
for L in $LIST; do
	echo ssh $L mkdir -p /home/lab/data
	echo scp /home/lab/data/2000-0.txt $L:/home/lab/data/2000-0.txt
done


#
# (2) Run
#

# clean
rm -fr /home/lab/data/pg2000-w

# spark cluster
./spark/sbin/start-all.sh
sleep 2
pyspark < /home/lab/data/eqdlm.py
sleep 3
./spark/sbin/stop-all.sh

# show results
ls -als /home/lab/data/pg2000-w

