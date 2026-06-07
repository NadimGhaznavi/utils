#!/bin/bash
#

rsync -avr --delete /exports/old/* /exports/new > /var/log/sync-drives.log
