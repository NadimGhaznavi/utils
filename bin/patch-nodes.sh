#!/bin/bash

APP=run-on-all-nodes.sh

$APP sudo apt-get update
$APP sudo apt -y autoremove
$APP sudo apt-get -y upgrade
$APP sudo apt-get -y dist-upgrade

