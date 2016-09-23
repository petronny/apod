#!/bin/sh
[ ! -d image ] && mkdir image
for i in json/*.json
do
	echo $i
	media_type=`jq '.media_type' $i`
	if [ "$media_type" == '"image"' ]
	then
		url=`jq '.hdurl' $i | sed 's/"//g'`
		date=`echo $i | sed -e 's/json\///' -e 's/\.json$//'`
		ext=`echo $url | sed -e 's/.*\///' -e 's/.*\.//' -e 's/"$//'`
		[ -f image/$date.$ext ] && continue
		wget -O image/$date.$ext $url
		sleep 10
	fi
done
