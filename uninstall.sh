#!/bin/bash

# Set base path
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# Import variables
source $PWD/utils/variables.cfg

# Remove Speebmob script on all systems.
if [ -e "$SM_BIN" ] || [ -e "$SM_OPT" ] || [[ $(which speedmob) != "" ]]; then
	echo "Removing speedmob..."
	if [ ! -e "$SM_BIN" ]; then
		unlink $SM_BIN
	fi
	if [ ! -e "$SM_OPT" ]; then
		rm -r $SM_OPT
	fi
fi

# Remove cron or launchd
case $OS in
	Darwin)
		# Remove speedmob script, crontab and/or launchd.
		echo "Removing Launchd..."
		/bin/launchctl unload $LAUNCH_AGENT_PLIST
		rm -f $LAUNCH_AGENT_PLIST
	    ;;
	Linux)
		echo "Removing crontab task..."
		crontab -l | grep -v 'speedmob'  | crontab -
	    ;;
	*) echo "System not supported."
	   exit 1
	   ;;
esac