#!/bin/bash

LOG=/var/log/patch-nodes.log

NOW=$(date)
echo "$NOW: Starting patch process" >> $LOG
apt update >> $LOG
apt -y autoremove  >> $LOG
apt -y upgrade >> $LOG
apt -y dist-upgrade >> $LOG
NOW=$(date)
echo "$NOW: Patch process complete" >> $LOG

