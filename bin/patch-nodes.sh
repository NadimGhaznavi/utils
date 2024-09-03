#!/bin/bash

APP=run-on-all-nodes.sh

$APP sudo apt-get update
$APP sudo apt-get -y upgrade
$APP sudo apt autoremove
