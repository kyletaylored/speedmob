#!/bin/bash
OS=`echo $(uname)`
# Install speedmob
case $OS in
	Darwin)
		echo "Mac OS detected..."
		if [[ $(type -t brew) = "" ]]; then
			echo "Homebrew not available, and is required for installation. Please install Homebrew by visiting https://brew.sh"
	   		exit 1
		fi
		git clone -q https://github.com/kyletaylored/speedmob
		cd speedmob
		brew install speedtest-cli jq bc
		sudo mv speedmob /usr/local/bin/speedmob
		chmod +x install_crontab
		./install_crontab
	    ;;
	Linux)
		echo "Linux detected..."
		sudo apt-get update
		sudo apt-get install jq bc git -y
		git clone -q https://github.com/kyletaylored/speedmob
		cd speedmob
		sudo mv speedmob /usr/local/bin/speedmob
		chmod +x install_crontab install_raspian
		./install_raspian
		./install_crontab
	    ;;
	*) echo "System not supported."
	   exit 1
	   ;;
esac
