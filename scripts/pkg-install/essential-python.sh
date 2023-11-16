#!/bin/bash
set -x

# 1) Install Python
apt-get update && \
apt-get install -y --allow-downgrades --allow-change-held-packages --no-install-recommends \
        python3-minimal \
        python3-pip \
        python3-setuptools \
        jupyter-notebook \
        virtualenv \
        && \
apt-get clean 

