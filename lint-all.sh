#!/bin/bash
for dir in $(ls -d julb/*/ ); do
	echo "---"
	helm lint $dir
done
