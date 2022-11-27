#!/usr/bin/bash

gnome-screenshot -f /tmp/screenshot.png
convert /tmp/screenshot.png -filter Gaussian -blur 0x16 /tmp/screenshot.png
# convert bg.png \( test.png -scale 50% \) -gravity southeast  -composite output.png;
i3lock -i /tmp/screenshot.png -t
rm /tmp/screenshot.png

