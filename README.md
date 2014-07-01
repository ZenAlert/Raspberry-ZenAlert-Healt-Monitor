Raspberry-ZenAlert-Healt-Monitor
================================


## Overview

"Raspberry Health Monitor" uses ZenAlert Cloud Platform to alert you in case of disk space low, absence of electricity or connectivity of the Raspberry Pi. 

## Requirements

* Raspberry Pi 
* cUrl 
* ZenAlert free account

## Installation

Start with installing curl:
	
	* sudo apt-get install curl (in debian/ubuntu)


* Save healtmonitor.sh on your SD Card
* Make script executable: chmod +x healtmonitor.sh
* Use crontab for execute the script every five minute

edit crontab configuration file:

	crontab -e
    

and append this line at end of crontab configuration file:
	
	*/5 * * * * /mypath/healtmonitor.sh
	
save and exit
