# NodePing Port Scripts Installation Script
yum install xinetd -y

# Create test-scripts directory for xinetd
/bin/mkdir -p /etc/xinetd.d/nodeping

# Set Permissions (TODO: chroot xinetd)
/bin/chown -R root:root /etc/xinetd.d

# copy over test scripts
/bin/cp ../test-scripts/* /etc/xinetd.d/

# Restart server to include new test scripts
/etc/init.d/xinetd restart
