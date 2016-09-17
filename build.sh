#!/bin/bash

set -e # break on error.
set -u # break on using undefined variable.

# Go to right place
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

ID=$(git rev-parse --short=12 HEAD)
CNAME="registry.service.consul/loadbalancer:$ID"

echo "-- Build deployment container ($CNAME)"
docker build -t $CNAME .

echo "-- Push to registry"
docker push $CNAME

echo "-- Refresh Nomad Deployment"
cp nomad.hcl /tmp/nomad.hcl
sed -i -e "s#registry.service.consul/loadbalancer#$CNAME#" /tmp/nomad.hcl
sed -i -e "s#{password}#$1#" /tmp/nomad.hcl
docker cp /tmp/nomad.hcl nomad:/tmp/nomad.hcl
docker exec -ti nomad nomad run -address=http://192.168.1.51:4646 /tmp/nomad.hcl

echo "-- Done!"
