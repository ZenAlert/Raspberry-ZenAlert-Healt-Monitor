#!/bin/bash
# Based on script at http://www.cyberciti.biz/tips/shell-script-to-watch-the-disk-space.html
#
# set -x
#
# Shell script to monitor or watch the disk space on Raspberry Pi
# It will send an Event Signal if the use percentage of space is >= 90%.
# -------------------------------------------------------------------------
# set alert level 90% is default
ALERT=90
# Exclude list of unwanted monitoring, if several partions then use "|" to separate the partitions.
# An example: EXCLUDE_LIST="/dev/hdd1|/dev/hdc5"
EXCLUDE_LIST="rootfs|devtmpfs"
#
# set THING_ID and API_KEY with your data (you need a free account Zen Alert - www.zenalert.com)	    
THING_ID="2C5E3620-FDB0-E7F5-5F37-12B77FE29916"
API_KEY="ADF42336-FECA-11E3-A952-123143011977"
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
function main_prog() {
	while read output;
	do
	#echo $output
	  usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1)
	  partition=$(echo $output | awk '{print $2}')
	  if [ $usep -ge $ALERT ] ; then
	    eventDescription="Running+out+of+space+\"$partition+($usep%)\"+on+$(hostname).+Timestamp:+$(date +"%Y-%m-%d")+$(date +"%T")" 
	    # send an Event Signal 
	    curl "https://api.zenalert.com/signal?code=warning&thing_id="$THING_ID"&api_key="$API_KEY"&description="$eventDescription
	  fi
	done
}

if [ "$EXCLUDE_LIST" != "" ] ; then
  df -H | grep -vE "^Filesystem|File system|tmpfs|cdrom|${EXCLUDE_LIST}" | awk '{print $5 " " $1}' | main_prog
else
  df -H | grep -vE "^Filesystem|File system|tmpfs|cdrom" | awk '{print $5 " " $1}' | main_prog
fi

# send a Vital Signal 
curl "https://api.zenalert.com/signal?code=alive&thing_id="$THING_ID"&api_key="$API_KEY
