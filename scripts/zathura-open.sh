#!/usr/bin/env bash

file=$(fdfind --base-directory / -e pdf -I -a | rofi -dmenu)

# Exit if $file is empty
if test -z "$file"
then
    exit
fi

nohup zathura $file > /dev/null

