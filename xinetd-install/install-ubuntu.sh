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

#/bin/rm -rf /etc/nodeping



echo "NodePing Check Scripts Install Complete!"
