#!/bin/bash

echo "Executing command on all nodes"
echo "======================================"
echo "$*"
echo "======================================"
echo

DOM="osoyalce.com"

for node in islands.$DOM phoebe.$DOM maia.$DOM kermit.$DOM bingo.$DOM paris.$DOM; do
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

