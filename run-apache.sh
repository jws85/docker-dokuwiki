#!/bin/bash

# Wipe out Apache PID files; Apache will not start otherwise
# Taken from the Fedora Cloud folks here:
# https://github.com/fedora-cloud/Fedora-Dockerfiles/blob/master/apache/run-apache.sh
rm -rf /run/apache2/*

# Run Apache
exec apachectl "-DFOREGROUND"
