#!/bin/bash
# Detect the operating system type
if [[ "$OSTYPE" == "darwin"* ]]; then
  ln_option=""
else
  ln_option="rT"
fi

config_dir="$HOME/.config"

# Create the config directory if it doesn't exist
mkdir -p "$config_dir"

# Link the nvim directory to the config directory
ln -sf"$ln_option" "$PWD/pure_nvim/nvim" "$config_dir/"

#mkdir ~/.config
#ln -sf ./pure_nvim/nvim ~/.config/nvim
