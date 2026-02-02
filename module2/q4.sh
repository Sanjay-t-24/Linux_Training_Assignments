#!/bin/bash
ps -eo pid,%mem --sort=-%mem | head -n 2 > output/high_mem_process.txt
cat output/high_mem_process.txt
