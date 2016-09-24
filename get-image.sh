#!/bin/sh
[ ! -d image ] && mkdir image
download(){
	url=`jq '.hdurl' $1 | sed 's/"//g'`
	date=`echo $1 | sed -e 's/json\///' -e 's/\.json$//'`
	ext=`echo $url | sed -e 's/.*\///' -e 's/.*\.//' -e 's/"$//'`
	[ -f image/$date.$ext ] && return
	wget -O image/$date.$ext $url
	sleep 4
}
[ -n "$1" ] && download $1 && exit
for i in json/*.json
do
	echo $i
	media_type=`jq '.media_type' $i`
	if [ "$media_type" == '"image"' ]
	then
		download $i
	fi
done
