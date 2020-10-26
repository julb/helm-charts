#!/bin/bash
for dir in $(ls -d julb/*/ ); do
	helm lint $dir
done
