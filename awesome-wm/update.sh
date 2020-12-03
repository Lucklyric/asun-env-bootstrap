#!/bin/bash
CURRENTDIR=$PWD
git pull
ln -srfT awesome/rc.lua ~/.config/awesome/rc.lua
ln -srfT awesome/themes ~/.config/awesome/themes
cd ~/.config/awesome/vicious
git pull
cd ~/.config/awesome/awesome-wm-widgets
git pull
cd $CURRENTDIR
