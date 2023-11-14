#!/bin/bash
#set -x

# machines -> hosts
rm -fr /work/export/hosts /work/export/hostname
touch  /work/export/hosts /work/export/hostname
I=1
while IFS= read -r line
do
  echo "$line nodo$I" >> /work/export/hosts
  echo       "nodo$I" >> /work/export/hostsname
  I=$((I+1))
done < /work/machines

# add to /etc/hosts
cp /etc/hosts /etc/hosts.backup.$$
echo ""                 >> /etc/hosts
cat /work/export/hosts  >> /etc/hosts
echo ""                 >> /etc/hosts

# add workers to /home/lab/spark/conf/workers
tail -n +2 /work/export/hostsname > /home/lab/spark/conf/workers

# last
## su - lab
cd /home/lab

