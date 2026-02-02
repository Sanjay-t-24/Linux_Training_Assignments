#!/bin/bash
ip route | grep default | awk '{print $3}' | sort > output/gateways.txt
cat output/gateways.txt
