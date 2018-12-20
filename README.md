# Speed Mob

[![GitHub stars](https://img.shields.io/github/stars/kyletaylored/speedmob.svg)](https://github.com/kyletaylored/speedmob/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/kyletaylored/speedmob.svg)](https://github.com/kyletaylored/speedmob/network)
[![GitHub issues](https://img.shields.io/github/issues/kyletaylored/speedmob.svg)](https://github.com/kyletaylored/speedmob/issues)
[![Inspired by natterstefan](https://img.shields.io/badge/Inspired%20by-natterstefan-blue.svg)](https://github.com/natterstefan/speedtest-cron)
[![Twitter](https://img.shields.io/twitter/url/https/github.com/kyletaylored/speedmob.svg?style=social)](https://twitter.com/intent/tweet?text=https://github.com/kyletaylored/speedmob)
[![Twitter Follow](https://img.shields.io/twitter/follow/kyletaylored.svg?style=social&label=Follow)](https://twitter.com/kyletaylored)


An easy to use script test the speed (down-, upload and ping) of your ISP regularly (cronjob), and contribute to a common datastore. [Inspired (Forked) by natterstefan's speedtest_cron on Github][natterstefan].


## Idea

To run speedtests we use [speedtest-cli by Matt Martz][spcli]. For consistent results, you could always use the same test server, but for more dynamic results we will use the randomly selected server. Regular tests can be used to identify trends.

The tests should be performed as close to the modem / router as possible. In any case I recommend you use a Ethernet (network) cable.

Ideal would be the execution directly on your router. If it has a storage for storing the measurement data and has enough power to run Python, you should run the code on the router. Otherwise I recommend to use a RaspberryPi or similar, which is connected by cable to the router.


## System Requirements

A UNIX-like system with Python (at least 2.5) is required to run the scripts.

## Installation

You can try our installation script (beta), or install dependencies manually.

```bash
curl -fsSL speed.angrybear.club/get | bash
```

#### On Mac
``` bash
git clone https://github.com/kyletaylored/speedmob
cd speedmob
brew install speedtest-cli jq bc
chmod +x install_crontab
./install_crontab
```

#### On Raspian / Linux
``` bash
git clone https://github.com/kyletaylored/speedmob
cd speedmob
sudo apt-get update
sudo apt-get install jq bc -y
chmod +x install_crontab install_raspian
./install_raspian
./install_crontab
```

### speedtest_crontab

_speedtest_cron_ should run regularly to be able to analyse trends. To do so you should add a cronjob to `/etc/crontab` or ```crontab -e```. Take a look at the _speedtest_crontab_ file and replace ```/path/to/this/folder/``` with the actual path.

### speedtest_ifttt

After reading the "[Use Raspberry Pi to Measure Broadband Speeds to Hold Your ISP Accountable][iftttmaker]" article I decided to implemented [Aallan's work][gistaallan] here too. Because I would like to get either a push notification when the internet speed drops or add the result to a Google Spreadsheet automatically. This is how you use it:

- rename ```example.cfg``` to ```speedtest.cfg```
- setup the [maker channel on IFTTT][maker]
- add an Applet [like this one][ifapplet]
- add the secret key and event name to the `speedtest.cfg`
- run the script ```./speedtest_ifttt```

## Development

Improvements, suggestions or bug fixes are very welcome. Just create a pull request.


## Similar projects

There are other projects available, like [speedtest-cli-extras by HenrikBengtsson][spclix], [speedtest-cron by vwillcox][vwillcox] or [speedtest-cron by brainTrain][brainTrain]. The last one makes use of [Google Spreadsheets and IFTTT's Maker][iftttmaker].

 [natterstefan]: https://github.com/natterstefan/speedtest-cron
 [spcli]: https://github.com/sivel/speedtest-cli
 [ifapplet]: https://ifttt.com/applets/49618185d-log-speedtest-results-to-spreadsheet
 [maker]: https://ifttt.com/maker

 ## Specific to this repo
 Install Speedtest CLI, JQ, and BC on Raspberry Pi to parse JSON and do math in bash.
 ```bash
 sudo apt-get install speedtest-cli jq bc
 ```

 Install JQ / Speedtest on Mac.
  ```bash
  brew install speedtest-cli jq bc
  ```

 If you want to auto-add to cron, you can use this command on Linux / Raspian. When in the root project directory, enter the following:
 ```bash
 # Run test every 30 minutes.
 DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
 echo "*/30 * * * * ${USER} ${DIR}/speedtest_proxy.sh" | crontab
 ```

 On Mac, we drop the user requirement. This will eventually be a launchd command.
 ```bash
 # Run test every 30 minutes.
 DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
 echo "*/30 * * * * ${DIR}/speedtest_proxy.sh" | crontab
 ```
