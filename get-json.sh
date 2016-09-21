#!/bin/sh
[ ! -d json ] && mkdir json
api_key=`cat api-key`
apod(){
	[ -f json/$1.json ] && return
	sleep 10
	wget -q "https://api.nasa.gov/planetary/apod?api_key=$api_key&hd=true&date=$1" -O json/$1.json
}
firstday=19950922
today=`date +%Y%m%d`
firstday_s=`date -d "$firstday" +%s`
today_s=`date -d "$today" +%s`
while [ "$firstday_s" -le "$today_s" ]
do
	day=$(date -d @$firstday_s +"%Y-%m-%d")
	echo $day
	firstday_s=$((firstday_s+86400))
	apod $day
done
exit
