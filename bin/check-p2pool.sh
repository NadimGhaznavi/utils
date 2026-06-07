#!/bin/bash

cd /opt/prod/p2pool
clear
echo status >> run/p2pool.stdin
sleep 1
echo workers >> run/p2pool.stdin 
sleep 1 
tail -100 logs/p2pool.log
