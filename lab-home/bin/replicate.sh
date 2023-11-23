#!/bin/bash
set -x


#
if [ $# -lt 1 ]; then
	echo "Usage: replicate <machine file> <file to be replicated>"
	exit
fi

# get local data
MACHINE_FILE=$1
REPLICATE_FILE=$2
REPLICATE_DIR=$(dirname $2)

LIST=$(cat ${MACHINE_FILE})
for L in $LIST; do
    ssh $L mkdir -p  ${REPLICATE_DIR}
    scp ${REPLICATE_FILE}  $L:${REPLICATE_FILE}
done

