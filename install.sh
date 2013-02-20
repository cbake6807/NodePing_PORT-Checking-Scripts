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
	if ! which git > /dev/null; then
      apt-get install git-core -y
    else
      exit 0;		
	fi

	`which git` clone git://github.com/cbake6807/NodePing_PORT-Checking-Scripts.git /etc/nodeping
	cd /etc/nodeping
	sh xinetd-install/install-ubuntu.sh
	;;
centos)
	echo "No CentOS Support Yet";
	exit 0;
	;;
debian)
	bash xinetd-install/install-ubuntu.sh
	;;
darwin)
	echo "No Darwin Support Yet";
	exit 0;
	;;
esac

