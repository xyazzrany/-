#!/bin/bash

# Remove Apache2 packages and related files
apt-get --purge remove apache2
apt-get --purge remove apache2.2-common
apt-get --purge remove apache2-doc
apt-get --purge remove apache2-utils

# Auto-remove unused packages
apt-get autoremove

# Remove Apache-related configuration files
find /etc -name "*apache*" | xargs rm -rf
rm -rf /var/www
rm -rf /etc/libapache2-mod-jk

# Purge remaining Apache2 packages
dpkg -l | grep apache2 | awk '{print $2}' | xargs dpkg -P

# Check if any Apache2 packages remain
dpkg -l | grep apache2
