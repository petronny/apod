#!/bin/sh
[ ! -d video ] && mkdir video
for i in json/*.json
do
	media_type=`jq '.media_type' $i`
	if [ "$media_type" == '"video"' ]
	then
		url=`jq '.hdurl' $i | sed 's/"//g'`
		date=`echo $i | sed -e 's/json\///' -e 's/\.json$//'`
		ext=`echo $url | sed -e 's/.*\///' -e 's/.*\.//' -e 's/"$//'`
		[ -f video/$date.$ext ] && continue
		you-get -x localhost:8123 -i $url
		sleep 10
	fi
done
