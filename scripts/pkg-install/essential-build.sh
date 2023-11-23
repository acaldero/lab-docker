#!/bin/bash
set -x

apt-get update && \
apt-get install -y --allow-downgrades --allow-change-held-packages --no-install-recommends \
        build-essential \
        gcc g++ \
        libtool \
        \
        make cmake \
        autoconf automake \
        doxygen \
        \
        default-jdk \
        \
        gdb valgrind \
        nasm \
        \
        git subversion \
	rpcbind \
	libjson-c-dev \
        jq \
        yamllint \
        \
        libmxml1 libmxml-dev \
	libmosquitto-dev \
        \
        libjpeg-dev \
        libpng-dev \
        zlib1g-dev \
        libcurl3-dev \
        libfreetype6-dev \
        libhdf5-serial-dev \
        libzmq3-dev \
        && \
    apt-get clean 

