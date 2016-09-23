#!/bin/sh
[ ! -d video ] && mkdir video
for i in json/20[123456789]*.json
do
	media_type=`jq '.media_type' $i`
	if [ "$media_type" == '"video"' ]
	then
		echo $i
		url=`jq '.url' $i | sed -e 's/"//g' -e 's/^\/\//http:\/\//' `
		date=`echo $i | sed -e 's/json\///' -e 's/\.json$//'`
		#ext=`echo $url | sed -e 's/.*\///' -e 's/.*\.//' -e 's/"$//'`
		you-get -x localhost:8123 -O video/$date.mp4 $url
		#sleep 10
	fi
done
