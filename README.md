# Speed Mob

[![GitHub stars](https://img.shields.io/github/stars/kyletaylored/speedmob.svg)](https://github.com/kyletaylored/speedmob/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/kyletaylored/speedmob.svg)](https://github.com/kyletaylored/speedmob/network)
[![GitHub issues](https://img.shields.io/github/issues/kyletaylored/speedmob.svg)](https://github.com/kyletaylored/speedmob/issues)
[![Inspired by natterstefan](https://img.shields.io/badge/Inspired%20by-natterstefan-blue.svg)](https://github.com/natterstefan/speedtest-cron)
[![Twitter](https://img.shields.io/twitter/url/https/github.com/kyletaylored/speedmob.svg?style=social)](https://twitter.com/intent/tweet?text=https://github.com/kyletaylored/speedmob)
[![Twitter Follow](https://img.shields.io/twitter/follow/kyletaylored.svg?style=social&label=Follow)](https://twitter.com/kyletaylored)


[Inspired (Forked) by natterstefan's speedtest_cron on Github][natterstefan], Speed Mob uses the same principles of running a speedtest on a regular schedule (every 30 minutes by default) that then submits the results to our Speed Mob server (a Lumen app that writes to a MySQL database) where it will be used to aggregate and showcase all speedtest results submitted.

For anyone interested in making their own Speed Mob server, feel free to use this as a source! The installation supports both Mac OS(X) and Linux (Raspian) to use as clients that submit data to the server, and utilized as common tooling as possible for consitency (bash, python, jq, etc).


## Idea

While unable to run directly on a router, it's now super simple to setup and install on a Raspberry Pi connected to your network, or even on your own laptop (Mac or Linux). We want the dynamic results, so we use randomly selected servers on a regular interval to identify trends.

The reason I started this project was because my FiOS bill increased after a promo period ended and I was considering switching to Spectrum. While FiOS is preferred for my work-from-home job, the improved download speeds from Spectrum was enticing for the price - but I also know that there have been occasional outages for Charter/Spectrum in our area, and knowing that the infrastructure relies on cable/coax and a shared node (i.e, everyone comes home after work and turns on Netflix and we all suffer).

I signed up for Spectrum, but wanted to run a regular speedtest for each FiOS and Spectrum to compare the results. Initially, I was using the IFTTT method from [speedtest-cron][natterstefan] that wrote a JSON string to a Google spreadsheet, then utilized Data Studio to showcase the results. That ran into it's limits as Google Sheets will create a new sheet after 1k or 2k rows, meaning I stopped getting new data into the dashboard.

With this update, I'm able to contribute the results to a common datastore and can let anyone else contribute their own data as well! This will give us a great visualization of ISP speeds in different areas at different times in a super cool way.

![SpeedMob Data Studio](https://i.imgur.com/EYK8BSM.png)
[SpeedMob Data Studio](https://datastudio.google.com/embed/reporting/1njU6fHSqJA8Gmqx_RbC6XHCIvCx0yie8/page/Zaqb)

## System Requirements

A UNIX-like system with Python (at least 2.5) is required to run the scripts.

## Installation

You can try our installation script, or install dependencies manually.

```bash
curl -fsSL https://raw.githubusercontent.com/kyletaylored/speedmob/master/installer.sh | bash
```

#### Manual install
``` bash
git clone https://github.com/kyletaylored/speedmob
cd speedmob
chmod +x installer.sh
./installer.sh
```

#### Uninstall
``` bash
chmod +x uninstall.sh
./uninstall.sh
```

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
[spclix]: https://github.com/HenrikBengtsson/speedtest-cli-extras
[vwillcox]: https://github.com/vwillcox/speedtest-cron
[brainTrain]: https://github.com/brainTrain/speedtest-cron
[speedtest]: http://www.speedtest.net/
[jsspcr]: https://gitgud.io/J0s3f/speedtest_cron
[iftttmaker]: http://makezine.com/projects/send-ticket-isp-when-your-internet-drops/
[gistaallan]: https://gist.github.com/aallan/bafc70a347f3b9526d30
[ifapplet]: https://ifttt.com/applets/49618185d-log-speedtest-results-to-spreadsheet
[maker]: https://ifttt.com/maker
[natterstefan]: https://github.com/natterstefan/speedtest-cron


## Support

Support obviously not guaranteed, but I'll try my best.

- Twitter at <a href="http://twitter.com/kyletaylored" target="_blank">`@kyletaylored`</a>



## License and Disclaimer

By installing this software, you agree to share your speedtest result data with the speedmob server for the purpose of research and an exercise in data aggregation. We do not collect any personally identifiable information other than utilizing your public IP address to fetch GeoIP coordinates for the purpose of mapping and filtering data. You will not hold the repository owner, Kyle Taylor, or the software developers of the tools that speedmob utilizes accountable for any actions you take or damage caused.

[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

- **[MIT license](http://opensource.org/licenses/mit-license.php)**