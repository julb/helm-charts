#!/bin/bash
for dir in $(ls -d */ | sed 's#/##'); do
	helm lint $dir
done
