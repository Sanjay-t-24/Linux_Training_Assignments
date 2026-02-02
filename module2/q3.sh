#!/bin/bash
grep "ERROR" log.txt | grep -v "DEBUG" > output/filtered_log.txt
cat output/filtered_log.txt
