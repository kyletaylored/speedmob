#!/bin/bash
# Agree to send your data.
echo "This project is purely for research and as a data aggreagation exercise. We do not collect any personally identifiable information such as MAC addresses or public IP address, other than the vague geoIP data attributed to that public IP address for mapping and filtering purposes."
read -r -p "Do you agree to share your speedtest results with the speedmob data collection server? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]];
then
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
else
	echo "You must agree to the terms set above."
fi