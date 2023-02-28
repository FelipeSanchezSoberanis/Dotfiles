#!/usr/bin/env bash

file=$(fdfind --base-directory /home/felipe/ -e pdf -I | rofi -dmenu -i -theme ~/.config/rofi/launchers/type-4/style-2.rasi)

# Exit if $file is empty or not a valid file
if [ -z "$file" ] || [ ! -f "$file" ]
then
    exit
fi

nohup zathura "/home/felipe/$file" > /dev/null

