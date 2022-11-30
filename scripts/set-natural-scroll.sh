#!/usr/bin/env sh

touchpad_id=$(xinput list | rg -i "touchpad" | sed "s/.\+id=\([0-9]\+\)\+.\+/\1/g")

natural_scroll_property=$(xinput list-props $touchpad_id | rg -i "natural scroll" | sed "s/.\+default.\+//gi")
natural_scroll_property_id=$(echo $natural_scroll_property | sed "s/.\+(\([0-9]\+\)).\+/\1/g")

xinput set-prop $touchpad_id $natural_scroll_property_id 1

