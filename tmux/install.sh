#!/bin/bash
git pull
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -srf .tmux.conf ~/.tmux.conf
