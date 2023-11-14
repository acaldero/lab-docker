#!/bin/bash
#set -x

# machines -> hosts
rm -fr /work/export/hosts /work/export/names
touch  /work/export/hosts /work/export/names
I=1
while IFS= read -r line
do
  echo "$line nodo$I" >> /work/export/hosts
  echo       "nodo$I" >> /work/export/names
  I=$((I+1))
done < /work/machines

# add to /etc/hosts
if [ ! -f /etc/hosts.base ]; then
     cp /etc/hosts /etc/hosts.base
fi
cat /etc/hosts.base /work/export/hosts > /etc/hosts

