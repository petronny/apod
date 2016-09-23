#!/bin/sh
cd `dirname $0`
sh get-json.sh
git add .
git commit -m "[$(LANG=C date)]auto update"
git push
