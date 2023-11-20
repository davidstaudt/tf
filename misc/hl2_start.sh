#!/bin/bash

# set -v
# set -x

function cleanup {

    steam -shutdown
    kill -KILL $perfPid
    xrandr --output DP-2 --gamma 1:1:1
    gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
    gsettings set org.gnome.shell disable-user-extensions false
    gsettings set org.gnome.mutter overlay-key 'Super_L'
    # gsettings set org.gnome.DejaDup periodic true
    powerprofilesctl set balanced
}
trap cleanup EXIT

export SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS=0
export __GL_MaxFramesAllowed=1

# gsettings set org.gnome.DejaDup periodic false
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled false
sleep 2
gsettings set org.gnome.shell disable-user-extensions true
gsettings set org.gnome.mutter overlay-key 'Super_R'
xrandr --output DP-2 --gamma 1.2:1.2:1.2

bash -c "while :; do powerprofilesctl set performance; sleep 60; done" &
perfPid=$!

read -d '' options  << EOM
-novid 
-nostartupsound 
-nojoy 
-nosteamcontroller 
-nohltv 
-particles 1 
-precachefontchars 
-reuse 
-softparticlesdefaultoff 
-NoQueuedPacketThread 
-gl_enablesamplerobjects 
-gl_nv_bindless_texturing  
EOM

/home/dstaudt/.local/share/Steam/ubuntu12_32/reaper SteamLaunch AppId=440 -- \
"/home/dstaudt/.local/share/Steam/steamapps/common/Team Fortress 2/hl2.sh" -game tf -steam ${options}