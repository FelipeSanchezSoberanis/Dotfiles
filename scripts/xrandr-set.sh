#!/usr/bin/env bash

displayFilesHome=~/Documents/display-layouts/
selectedFile=$(ls -1 "$displayFilesHome" | rofi -dmenu -i -theme ~/.config/rofi/launchers/type-4/style-2.rasi)
selectedFileFullPath="$displayFilesHome"/"$selectedFile"

if [ -z "$selectedFileFullPath" ] || [ ! -f "$selectedFileFullPath" ]
then
    exit
fi

bash "$selectedFileFullPath"

