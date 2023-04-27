#!/usr/bin/env bash

displayFilesHome=~/Documents/display-layouts/
selectedFile=$(ls -1 "$displayFilesHome" | rofi -dmenu -i -theme ~/.config/rofi/launchers/type-4/style-2.rasi)
selectedFileFullPath=$(readlink -f "$file")

if [ -z "$selectedFileFullPath" ] || [ ! -f "$selectedFileFullPath" ]
then
    exit
fi

bash "$selectedFileFullPath"

