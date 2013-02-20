# Simple display of available Free Ram for now
`which free` -m | grep Mem | awk '{ print $4 }'
