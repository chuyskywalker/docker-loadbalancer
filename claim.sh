#!/bin/bash -exu

MYIP=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')

echo `date` "Claiming web ownership as $MYIP..."

/usr/bin/sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no admin@192.168.1.1 \
 'nvram set vts_rulelist="<clusterfollow>80>'${MYIP}'>80>TCP"; nvram commit; service restart_firewall'

echo `date` "...Claimed! Sleeping forever now kthnxbye!"

while true; do sleep 600; done
