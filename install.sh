OS=$(awk '/DISTRIB_ID=/' /etc/*-release | sed 's/DISTRIB_ID=//' | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')
VERSION=$(awk '/DISTRIB_RELEASE=/' /etc/*-release | sed 's/DISTRIB_RELEASE=//' | sed 's/[.]0/./')
INSTALL_DIR="/etc/nodeping"
if [ -z "$OS" ]; then
    OS=$(awk '{print $1}' /etc/*-release | tr '[:upper:]' '[:lower:]')
fi

if [ -z "$VERSION" ]; then
    VERSION=$(awk '{print $3}' /etc/*-release)
fi

case $OS in
ubuntu)
	INSTALL_CMD="apt-get install"
	;;
centos)
	INSTALL_CMD="yum install"
	;;
debian)
	INSTALL_CMD="apt-get install"
	;;
darwin)
	echo "No Darwin Support Yet";
	exit 0;
	;;
esac

/bin/rm -rf $INSTALL_DIR

echo "Installing NodePing Check Scripts For $OS"

echo "Cloning NodePing CheckScripts Repository"

if ! which git > /dev/null; then
   echo -e "Command not found! Install? (y/n) \c"
   read
   if "$REPLY" = "y"; then
      $INSTALL_CMD git -y
   else
      exit 0;		
   fi
fi

[ -d foo ] || mkdir -p $INSTALL_DIR

`which git` clone git://github.com/cbake6807/NodePing_PORT-Checking-Scripts.git $INSTALL_DIR