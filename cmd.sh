#!/bin/bash -ex

/consul lock \
 -http-addr=192.168.1.51:8500 \
 -http-addr=192.168.1.52:8500 \
 -http-addr=192.168.1.53:8500 \
 -n=1 -verbose \
 webserver /claim.sh
