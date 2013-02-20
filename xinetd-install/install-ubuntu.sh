#!/bin/bash

# NodePing Port Scripts Installation Script
apt-get install xinetd -y

# Create test-scripts directory for xinetd
[ -d foo ] || mkdir -p /etc/nodeping

# Set Permissions (TODO: chroot xinetd)
/bin/chown -R root:root /etc/xinetd.d

# copy over test scripts
/bin/ln -s /etc/nodeping/xinetd-scripts/* /etc/xinetd.d/

# Restart server to include new test scripts
/etc/init.d/xinetd restart

echo "Installing PORT Services"

read /etc/nodeping/etc-services-ports.txt

filename="/etc/services"
SUCCESS=0
while read line ; do
	grep -q "$line" "$filename"
	
	if [ $? -eq $SUCCESS ]
	then
	  echo "$line found in $filename"
	else
	  echo "$line not found in $filename"
	  # If the line wasn't found, add it using an echo append >>
	  echo "$line" >> "$filename"
	  echo "$line added to $filename"
	fi	
	
done 


echo "NodePing Check Scripts Install Complete!"
