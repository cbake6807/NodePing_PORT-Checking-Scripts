#!/bin/bash

INSTALL_DIR="/etc/nodeping"

# NodePing Port Scripts Installation Script
apt-get install xinetd -y

# Set Permissions (TODO: chroot xinetd)
/bin/chown -R root:root /etc/xinetd.d

# copy over test scripts
/bin/ln -s $INSTALL_DIR/xinetd-scripts/* /etc/xinetd.d/ >> /dev/null

newservices=$INSTALL_DIR/etc-services-ports.txt
services="/etc/services"

echo "Installing PORT Services"

SUCCESS=0
while IFS= read -r line
do
	grep "$line" "$newservices"	
	if [ $? -eq $SUCCESS ]
	then
	  continue
	else
	  echo "$line" >> "$services"
	  echo "$line added to $services"
	fi	

done <"$services" >> /dev/null

echo "NodePing Check Scripts Install Complete!"

# Restart server to include new test scripts
/etc/init.d/xinetd restart

