# Speed Mob

[![GitHub stars](https://img.shields.io/github/stars/kyletaylored/speedmob.svg)](https://github.com/kyletaylored/speedmob/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/kyletaylored/speedmob.svg)](https://github.com/kyletaylored/speedmob/network)
[![GitHub issues](https://img.shields.io/github/issues/natterstefan/speedtest-cron.svg)](https://github.com/natterstefan/speedtest-cron/issues)
[![Inspired by J0s3f](https://img.shields.io/badge/Inspired%20by-natterstefan-blue.svg)](https://github.com/natterstefan/speedtest-cron)
[![Twitter](https://img.shields.io/twitter/url/https/github.com/kyletaylored/speedmob.svg?style=social)](https://twitter.com/intent/tweet?text=https://github.com/kyletaylored/speedmob)
[![Twitter Follow](https://img.shields.io/twitter/follow/kyletaylored.svg?style=social&label=Follow)](https://twitter.com/kyletaylored)


An easy to use script test the speed (down-, upload and ping) of your ISP regularly (cronjob). [Inspired (Forked) by natterstefan's speedtest_cron on Github][jsspcr].


## Idea

To run speedtests we use [speedtest-cli by Matt Martz][spcli]. For consistent results, always use the same test server. Regular tests can be used to identify trends.

The tests should be performed as close to the modem / router as possible. In any case I recommend you use a Ethernet (network) cable.

Ideal would be the execution directly on your router. If it has a storage for storing the measurement data and has enough power to run Python, you should run the code on the router. Otherwise I recommend to use a RaspberryPi or similar, which is connected by cable to the router.


## System Requirements

A UNIX-like system with Python (at least 2.5) is required to run the scripts.

## Installation

You can try our installation script (beta), or install dependencies manually.

```bash
curl -fsSL speed.angrybear.club/get | bash
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


 [spcli]: https://github.com/sivel/speedtest-cli
 [ifapplet]: https://ifttt.com/applets/49618185d-log-speedtest-results-to-spreadsheet
 [maker]: https://ifttt.com/maker

 ## Specific to this repo
 Install JQ and Speedtest CLI on Raspberry Pi to parse JSON in bash.
 ```bash
 sudo apt-get install speedtest-cli jq
 ```

 Install JQ / Speedtest on Mac.
  ```bash
  brew install speedtest-cli jq
  ```

 Add to crontab
 ```bash
 # Run speedtest every 10 minutes
 */10 * * * * pi /path/to/speedtest_proxy.sh
 ```

 Working on auto install (fix later)
 ```bash
 # Run test every 30 minutes.
 echo "*/30 * * * * ${USER} /path/to/dir/speedtest_proxy.sh" | crontab
 ```
