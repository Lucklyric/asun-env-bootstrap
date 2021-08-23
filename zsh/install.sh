#/bin/bash
if [ "$1" != "nozsh" ]; then
    sudo apt install zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/marlonrichert/zsh-autocomplete $HOME/.oh-my-zsh/custom/plugins/zsh-autocomplete
ln -srf ./ohmyzsh/lib/common_config.zsh $HOME/.oh-my-zsh/lib/common_config.zsh

