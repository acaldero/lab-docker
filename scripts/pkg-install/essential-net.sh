#!/bin/bash
set -x

apt-get update && \
apt-get install -y --allow-downgrades --allow-change-held-packages --no-install-recommends \
        \
        librdmacm1 \
        libibverbs1 \
        \
        ibverbs-providers \
        net-tools \
        netcat \
        \
        inetutils-ping \
        hping3 \
        \
        nmap \
        nload \
        iftop \
        && \
    apt-get clean 

