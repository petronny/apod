#!/bin/sh
for i in image/*
do
	[ `echo $i| grep 'jpg$' |wc -l` -eq 1 ] && continue
	identify $i
done
