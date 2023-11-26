#!/bin/bash
set -x

apt-get update && \
apt-get install -y --allow-downgrades --allow-change-held-packages --no-install-recommends \
        \
        aptitude apt-utils \
        zlib1g-dev ca-certificates pkg-config \
        software-properties-common gpg-agent \
        curl libcurl3-dev wget rsync \
        \
        ubuntu-restricted-extras \
        imagemagick \
        \
        sudo vim man-db \
        \
        kmod \
        nfs-common nfs-kernel-server \
	fuse libfuse-dev \
        \
        htop lsof lshw strace \
        \
        zip unzip unrar p7zip-full p7zip-rar \
        && \
    apt-get clean 

# tzdata: Configure region
echo "Europe/Madrid" > /etc/timezone

