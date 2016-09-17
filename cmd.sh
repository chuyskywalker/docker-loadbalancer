#!/bin/bash -ex

consul lock -n=1 -verbose webserver /claim.sh
