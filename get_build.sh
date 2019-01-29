#!/bin/bash
[ -f /builds/.keep ] || (echo "/builds volume not mounted!"; exit 1)

timestamp=`date "+%Y-%m-%dT%H%M%SZ" -u`
output_path=/builds/nginx-build_${timestamp}.tar.gz
cp /etc/nginx-build.tar.gz $output_path

echo $output_path