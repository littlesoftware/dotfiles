#!/bin/bash

USE_GAPS="t"
USE_KITTY="t"
USE_POLYBAR="t"
USE_FEH="t"
USE_COMPTON="t"

PACKAGES="scrot"

# Install packages
if [[ "${USE_GAPS}" == "t" ]]; then
    PACKAGES="${PACKAGES} i3-gaps"
else
    PACKAGES="${PACKAGES} i3"
fi
if [[ "${USE_KITTY}" == "t" ]]; then
    PACKAGES="${PACKAGES} kitty"
fi
if [[ "${USE_POLYBAR}" == "t" ]]; then
    PACKAGES="${PACKAGES} polybar"
fi
if [[ "${USE_FEH}" == "t" ]]; then
    PACKAGES="${PACKAGES} feh"
fi
if [[ "${USE_COMPTON}" == "t" ]]; then
    PACKAGES="${PACKAGES} compton"
fi

sudo apt install ${PACKAGES}
mkdir ~/.config

# Install i3
mkdir ~/.config/i3
cp -f i3/config ~/.config/i3/

# Install xrandr
cp -f xrandr.sh ~/.config/
tee -a ~/.config/i3/config <<- _EOF_
# Xrandr
exec ~/.config/xrandr.sh
_EOF_

# Install i3-gaps
if [[ "${USE_GAPS}" == "t" ]]; then
    tee -a ~/.config/i3/config <<- _EOF_
# Gaps
gaps inner 8
gaps outer -8
#smart_gaps on
_EOF_
fi

# Install feh
if [[ "${USE_FEH}" == "t" ]]; then
    mkdir Wallpapers
    tee -a ~/.config/i3/config <<- _EOF_
# Wallpaper
exec feh --bg-fill --randomize ~/Wallpapers/*
_EOF_
fi

# Install kitty
if [[ "${USE_KITTY}" == "t" ]]; then
    mkdir ~/.config/kitty
    cp -f kitty/kitty.conf ~/.config/kitty/
    sed -i 's/{%TERM%}/kitty/g' ~/.config/i3/config
else
    sed -i 's/{%TERM%}/i3-sensible-terminal/g' ~/.config/i3/config
fi

# Install Polybar
if [[ "${USE_POLYBAR}" == "t" ]]; then
    mkdir ~/.config/polybar
    cp -f polybar/config polybar/launch.sh ~/.config/polybar/
    tee -a ~/.config/i3/config <<- _EOF_
# Polybar
exec --no-startup-id ~/.config/polybar/launch.sh
_EOF_
else
    tee -a ~/.config/i3/config <<- _EOF_
bar {
    status_command i3status
}
_EOF_
fi

# Install compton
if [[ "$USE_COMPTON" == "t" ]]; then
    cp -f compton/compton.conf ~/.config/
    tee -a ~/.config/i3/config <<- _EOF_
# Compton (transparency)
exec --no-startup-id compton --config ~/.config/compton.conf
_EOF_
fi

# Incstall v3lock
sudo cp v3lock/v3lock /usr/bin/
sudo cp v3lock/lockoverlay.png /usr/share/pixmaps/

# Other config
tee -a ~/.config/i3/config <<- _EOF_
# Disable window title
default_border pixel
for_window [tiling] border pixel 2
smart_borders on

# Color settings
set \$bg_color            #2f343f
set \$inactive_bg_color   #000000
set \$text_color          #f3f4f5
set \$inactive_text_color #676e7d
set \$urgent_bg_color     #e53935

#                       border             background         text                 indicator
client.focused          \$bg_color          \$bg_color          \$text_color          #424242
client.focused_inactive \$inactive_bg_color \$inactive_bg_color \$inactive_text_color #424242
client.unfocused        \$inactive_bg_color \$inactive_bg_color \$inactive_text_color #424242
client.urgent           \$urgent_bg_color   \$urgent_bg_color   \$text_color          #424242

# language
#exec setxkbmap "us,ru" ",winkeys" "grp:alt_shift_toggle,grp_led:scroll"

# set default sound
# for get devices: pactl list short sinks
#exec pactl set-default-sink 'alsa_output.pci-0000_00_1b.0.analog-stereo'
#exec pactl set-default-sink 'alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1'

# hotkeys
bindsym $mod+z exec /usr/bin/v3lock
#bindsym $mod+Shift+b exec vivaldi
#bindsym $mod+Shift+m exec vivaldi --app=https://web.whatsapp.com
#bindsym $mod+Shift+n exec qtcreator
#bindsym --release $mod+c exec /usr/bin/scrotclip
bindsym $mod+Shift+p exec poweroff
bindsym $mod+Shift+o exec reboot

# autoload
exec ~/.config/autoload.sh

_EOF_

