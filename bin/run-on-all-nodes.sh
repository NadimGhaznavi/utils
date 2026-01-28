#!/bin/bash

echo "Executing command on all nodes"
echo "======================================"
echo "$*"
echo "======================================"
echo

DOM="osoyalce.com"

for node in kermit.$DOM paris.$DOM phoebe.$DOM bingo.$DOM islands.$DOM; do
	echo "Executing command: $*"
	echo "On node: $node"
	echo "-------------------------------------------------"
	ssh $node $*
	echo "-------------------------------------------------"
	echo
done

echo "Executing command: $*"
echo "On node: sally.$DOM"
echo "-------------------------------------------------"
$*
echo "-------------------------------------------------"
echo

