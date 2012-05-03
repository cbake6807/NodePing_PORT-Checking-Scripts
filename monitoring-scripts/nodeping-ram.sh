# Simple display of available Free Ram for now
/bin/free -m | grep Mem | awk '{ print $4 }'
