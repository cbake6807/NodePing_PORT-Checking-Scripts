#!/bin/bash

INSTALL_DIR="/etc/nodeping"

# NodePing Port Scripts Installation Script
apt-get install xinetd -y

# Set Permissions (TODO: chroot xinetd)
/bin/chown -R root:root /etc/xinetd.d

# copy over test scripts
/bin/ln -s $INSTALL_DIR/xinetd-scripts/* /etc/xinetd.d/

newservices=$INSTALL_DIR/etc-services-ports.txt
services="/etc/services"

echo "Installing PORT Services"

SUCCESS=0

cat $newservices | while read line; do 
	echo "Evaluating Service: $line"
	grep -q "$line" "$newservices"
	
	if [ $? -eq $SUCCESS ]
	then
	  echo "$line found in $services - SKIPPING"
	else
	  echo "$line" >> "$services"
	  echo "$line added to $services"
	fi	
	
done 


echo "NodePing Check Scripts Install Complete!"


# Restart server to include new test scripts
/etc/init.d/xinetd restart

