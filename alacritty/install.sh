#!/bin/bash
git pull
# Detect the operating system type
if [[ "$OSTYPE" == "darwin"* ]]; then
  ln_option="F"
else
  # Assume Ubuntu or similar
  config_dir="$HOME/.config/nvim"
  ln_option="fT"
fi

config_dir="$HOME/.config"

# Create the config directory if it doesn't exist
mkdir -p "$config_dir"

# Link the nvim directory to the config directory
ln -s"$ln_option" "$PWD/alacritty" "$config_dir"
