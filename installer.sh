#!/bin/bash

# Detect if speedmob exists.
if [[ $(type -t /usr/local/bin/speedmob) = "file" ]]; then
	echo "Speedmob detected, removing and reinstalling..."
	rm -rf /usr/local/opt/speedmob
	rm -rf /usr/local/bin/speedmob
fi

function sm_brew_install() {
	brew upgrade $1
	if [[ $? != 0 ]]; then
		brew install $1
	fi
}

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
		sm_brew_install speedtest-cli
		sm_brew_install jq
		sm_brew_install bc
		sudo mv speedmob /usr/local/opt/speedmob
		sudo ln -s /usr/local/opt/speedmob/speedmob /usr/local/bin/speedmob
		cd speedmob
		chmod +x utils/install_crontab
		./utils/install_crontab
	    ;;
	Linux)
		echo "Linux detected..."
		sudo apt-get update
		sudo apt-get install jq bc git -y
		git clone -q https://github.com/kyletaylored/speedmob
		sudo mv speedmob /usr/local/opt/speedmob
		sudo ln -s /usr/local/opt/speedmob/speedmob /usr/local/bin/speedmob
		cd speedmob
		chmod +x utils/install_crontab utils/install_raspian
		./utils/install_raspian
		./utils/install_crontab
	    ;;
	*) echo "System not supported."
	   exit 1
	   ;;
esac
