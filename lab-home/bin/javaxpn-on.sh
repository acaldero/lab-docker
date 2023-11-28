#!/bin/bash
set -x

if [ ! -f /usr/lib/jvm/java-11-openjdk-amd64/bin/java-real ]; then
      mv  /usr/lib/jvm/java-11-openjdk-amd64/bin/java  /usr/lib/jvm/java-11-openjdk-amd64/bin/java-real
fi

cp  /home/lab/bin/java-xpn  /usr/lib/jvm/java-11-openjdk-amd64/bin/java

