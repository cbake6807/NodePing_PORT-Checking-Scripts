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

echo "Installing NodePing Check Scripts For $OS"

echo "Cloning NodePing CheckScripts Repository"

if ! which git > /dev/null; then
   echo -e "Command not found! Install? (y/n) \c"
   read
   if "$REPLY" = "y"; then
      apt-get install gitcore -y
   else
      exit 0;		
   fi
fi

`which git` clone git://github.com/cbake6807/NodePing_PORT-Checking-Scripts.git /etc/nodeping