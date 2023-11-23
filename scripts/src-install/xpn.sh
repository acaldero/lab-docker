#!/bin/bash
set -x

# 1) Check arguments
if [ $# -lt 1 ]; then
	echo "Usage: $0 <full path where software will be downloaded>"
	exit
fi

# 2) Get arguments
DESTINATION_PATH=$1

# 3) Download XPN
mkdir -p ${DESTINATION_PATH}
cd       ${DESTINATION_PATH}
git clone https://github.com/xpn-arcos/xpn.git

# 4) Install XPN (from source code)
mkdir -p /home/lab/bin
cd       ${DESTINATION_PATH}/xpn
./scripts/compile/build-me-xpn.sh  -m /home/lab/bin/mpich/bin/mpicc  -i /home/lab/bin
chown -R lab:lab /home/lab

cd ${DESTINATION_PATH}/xpn/test/integrity/xpn
make -j $(nproc) all

