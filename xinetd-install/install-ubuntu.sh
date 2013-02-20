#!/bin/bash

INSTALL_DIR="/etc/nodeping"

# NodePing Port Scripts Installation Script
apt-get install xinetd -y

# Create test-scripts directory for xinetd
[ -d $INSTALL_DIR ] || mkdir -p $INSTALL_DIR

# Set Permissions (TODO: chroot xinetd)
/bin/chown -R root:root /etc/xinetd.d

# copy over test scripts
/bin/ln -s $INSTALL_DIR/xinetd-scripts/* /etc/xinetd.d/

# Restart server to include new test scripts
/etc/init.d/xinetd restart

echo "Installing PORT Services"

read $INSTALL_DIR/etc-services-ports.txt

services="/etc/services"
SUCCESS=0
while read line ; do
	echo "Evaluating Service: $line"
	grep -q "$line" "$services"
	
	if [ $? -eq $SUCCESS ]
	then
	  echo "$line found in $services - SKIPPING"
	else
	  echo "$line" >> "$services"
	  echo "$line added to $services"
	fi	
	
done 


echo "NodePing Check Scripts Install Complete!"
