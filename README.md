[![Build Status](https://travis-ci.org/uclapi/nginx-build.svg?branch=master)](https://travis-ci.org/uclapi/nginx-build)
# nginx-build
Dockerised build environment for Nginx with Shibboleth and Clear Headers Plugins.

## Usage
There are two scripts: `build.ps1` and `build.sh`. The former will work on PowerShell under Windows and the latter will work under *nix-like environments, including Linux.

Once the container has run, it will be destroyed and the output will be stored in the builds directory timestamped to UTC.
