#!/bin/bash
git pull
git clone https://github.com/vicious-widgets/vicious.git ~/.config/awesome/vicious
git clone https://github.com/streetturtle/awesome-wm-widgets ~/.config/awesome/awesome-wm-widgets
ln -srfT awesome/rc.lua ~/.config/awesome/rc.lua
ln -srfT awesome/themes ~/.config/awesome/themes
