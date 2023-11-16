#!/bin/bash
set -x

# 1) Check arguments
if [ $# -lt 1 ]; then
	echo "Usage: $0 <full path where software will be installed>"
	exit
fi

# 2) Get arguments
DESTINATION_PATH=$1
MPICC_PATH=$(whereis -b mpicc | awk '{ print $2 }')

# 3) Download XPN
mkdir -p ${DESTINATION_PATH}
cd ${DESTINATION_PATH}
git clone https://github.com/xpn-arcos/xpn.git

# 4) Install XPN (from source code)
mkdir -p /home/lab/bin
cd ${DESTINATION_PATH}/xpn
./scripts/compile/build-me-xpn.sh  -m ${MPICC_PATH} -i /home/lab/bin
chown -R lab:lab /home/lab

