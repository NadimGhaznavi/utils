#!/bin/bash

LOG=/var/log/patch-nodes.log

NOW=$(date)
echo "$NOW: Starting patch process" | tee -a $LOG
apt update | tee -a $LOG
apt -y autoremove | tee -a $LOG
apt -y upgrade | tee -a $LOG
apt -y dist-upgrade | tee -a $LOG
NOW=$(date)
echo "$NOW: Patch process complete" | tee -a $LOG
echo "Reboot your system a soon as possible"
