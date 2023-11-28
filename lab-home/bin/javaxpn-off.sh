#!/bin/bash
set -x

if [ ! -f /usr/lib/jvm/java-11-openjdk-amd64/bin/java-real ]; then
      cp  /usr/lib/jvm/java-11-openjdk-amd64/bin/java-real  /usr/lib/jvm/java-11-openjdk-amd64/bin/java
fi

