#!/usr/bin/env bash

OS=`echo $(uname)`
case $OS in
	Darwin)
		echo "Mac detected..."
		if [[ $(type -t brew) = "" ]]; then
			echo "Homebrew not available, and is required for installation. Please install Homebrew by visiting https://brew.sh"
	   		exit 1
		fi
		git clone -q https://github.com/kyletaylored/speedmob
		cd speedmob
		brew install speedtest-cli jq bc
		chmod +x install_crontab
		./install_crontab
	    ;;
	Linux)
		echo "Linux detected..."
		git clone -q https://github.com/kyletaylored/speedmob
		cd speedmob
		sudo apt-get update
		sudo apt-get install jq bc -y
		chmod +x install_crontab install_raspian
		./install_raspian
		./install_crontab

	    ;;
	*) echo "System not supported."
	   exit 1
	   ;;
esac
