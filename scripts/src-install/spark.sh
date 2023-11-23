#!/bin/bash
set -x

# 1) Check arguments
if [ $# -lt 1 ]; then
	echo "Usage: $0 <full path where software will be installed>"
	exit
fi

# 2) Get arguments
DESTINATION_PATH=$1
pip install py4j

# 3) Download and install Spark
mkdir -p ${DESTINATION_PATH}
wget https://dlcdn.apache.org/spark/spark-3.5.0/spark-3.5.0-bin-hadoop3.tgz -O ${DESTINATION_PATH}/spark-3.5.tar.gz
tar zxf ${DESTINATION_PATH}/spark-3.5.tar.gz     -C ${DESTINATION_PATH}
ln -s   ${DESTINATION_PATH}/spark-3.5.0-bin-hadoop3 ${DESTINATION_PATH}/spark

# 4) PATH
echo "# Spark"                                          >> /home/lab/.profile
echo "export PATH=${DESTINATION_PATH}/spark/bin:\$PATH" >> /home/lab/.profile
chown -R lab:lab ${DESTINATION_PATH}

