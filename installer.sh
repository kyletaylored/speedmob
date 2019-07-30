#!/bin/bash

# Get OS
OS=`echo $(uname)`

# Install paths
SM_OPT="/usr/local/opt/speedmob"
SM_BIN="/usr/local/bin/speedmob"

# Detect if speedmob exists.
if [ -e "$SM_BIN" ] || [ -e "$SM_OPT" ] || [[ $(which speedmob) != "" ]]; then
	echo "Speedmob detected, removing and reinstalling..."
	if [ -e "$SM_BIN" ]; then
		unlink $SM_BIN
	fi
	if [ -e "$SM_OPT" ]; then
		rm -rf $SM_OPT
	fi
fi

# Check if function exists.
function sm_fn_exists() {
 if [[ $(type -t $1) != "" ]]; then
 	echo 1
 else
 	echo 0
 fi
}

function sm_brew_install() {
	upgrade=$(sm_fn_exists $1)
	if [[ $upgrade == 0 ]]; then
		brew install $1
	else
		brew upgrade $1
	fi
}

function sm_install_nix() {
	echo "Installing speedmob..."
	# Create opt path if doesn't exist already.
	mkdir -p /usr/local/opt
	git clone -q https://github.com/kyletaylored/speedmob /usr/local/opt/speedmob
	ln -s /usr/local/opt/speedmob/speedmob /usr/local/bin/speedmob

	# Install speedmob and crontab
	cd /usr/local/opt/speedmob
	chmod +x utils/install_crontab utils/install_raspian
	bash utils/install_crontab

	if [[ $OS == "Linux" ]]; then
		bash utils/install_raspian
	fi
}

# Install speedmob
case $OS in
	Darwin)
		echo "Mac OS detected..."

		# Check for Homebrew
		if [[ $(type -t brew) = "" ]]; then
			echo "Homebrew not available, and is required for installation. Please install Homebrew by visiting https://brew.sh"
	   		exit 1
		fi

		# Homebrew
		sm_brew_install speedtest-cli
		sm_brew_install jq
		sm_brew_install bc

		# Install speedmob
		sm_install_nix
		
	    ;;
	Linux)
		echo "Linux detected..."
		sudo apt-get update
		sudo apt-get install jq bc git -y
		
		# Install speedmob
		sm_install_nix
	    ;;
	*) echo "System not supported."
	   exit 1
	   ;;
esac
