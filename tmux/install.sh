#!/bin/bash
if [[ "$OSTYPE" == "darwin"* ]]; then
  ln_option=""
else
  ln_option="rT"
fi
git pull
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf$ln_option $PWD/.tmux.conf ~/.tmux.conf
