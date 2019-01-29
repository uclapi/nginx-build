#!/bin/bash
[ -f /builds/.keep ] || (echo "/builds volume not mounted!"; exit 1)

timestamp=`date "+%Y-%m-%dT%H%M%SZ" -u`
filename=nginx-build_$timestamp.tar.gz
output_path=/builds/$filename
cp /etc/nginx-build.tar.gz $output_path

echo $filename > /builds/LATEST_BUILD

echo $output_path
