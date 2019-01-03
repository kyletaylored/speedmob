#!/bin/bash

# Import variables
source $PWD/variables.cfg

# Remove Speebmob script on all systems.
if [[ $(which speedmob) != "" ]]; then
	echo "Removing speedmob..."
	rm $(which speedmob)
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