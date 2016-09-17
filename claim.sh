#!/bin/bash -exu

echo "Claiming web ownership as $MYIP..."

/usr/bin/sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no admin@192.168.1.1 'nvram set vts_rulelist="<clusterfollow>80>'${MYIP}'>80>TCP"'

echo "...Claimed! Sleeping forever now kthnxbye!"

while true; do sleep 600; done
