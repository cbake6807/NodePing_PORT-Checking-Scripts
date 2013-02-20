#!/bin/bash

INSTALL_DIR="/etc/nodeping"

# NodePing Port Scripts Installation Script
apt-get install xinetd -y

# Set Permissions (TODO: chroot xinetd)
/bin/chown -R root:root /etc/xinetd.d

# copy over test scripts
/bin/ln -s $INSTALL_DIR/xinetd-scripts/* /etc/xinetd.d/ >> /dev/null

newservices=`cat $INSTALL_DIR/etc-services-ports.txt`
services="/etc/services"

echo "Installing PORT Services"

SUCCESS=0

echo $newservices | \
while read myLine
do
	grep -q "$myLine" "$services"	
	if [ $? -eq $SUCCESS ]
	then
	  continue
	else
	  echo "Adding $myLine"
	  echo ""
	  echo $myLine ; echo "" >> /etc/services
	fi	

done

echo "NodePing Check Scripts Install Complete!"

# Restart server to include new test scripts
/etc/init.d/xinetd restart

