#!/bin/bash

current_layout=$(setxkbmap -query | grep layout | sed "s/layout: //g")

if [ $current_layout = "latam" ]; then
	setxkbmap us
elif [ $current_layout = "us" ]; then
	setxkbmap latam
fi


