#!/usr/bin/env bash

gnome-screenshot -f /tmp/screenshot.png
convert /tmp/screenshot.png -filter Gaussian -blur 0x16 /tmp/screenshot.png
# convert /tmp/screenshot.png \( /home/felipe/Pictures/assets/lock.png -scale 10% \) -gravity center -composite /tmp/screenshot.png;
i3lock -i /tmp/screenshot.png -t
rm /tmp/screenshot.png

