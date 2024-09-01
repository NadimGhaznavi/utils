#!/bin/bash

# Script to be run from cron every 2 minutes to stop the M8 
# bluetooth speaker from turning itself off if it's not connected

/usr/bin/bluetoothctl info 56:5C:83:98:64:31 > /dev/null 2>&1
