#!/bin/bash
find . -maxdepth 1 -type f -size +1M > output/large_files.txt
cat output/large_files.txt
