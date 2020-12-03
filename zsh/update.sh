CURRENTDIR=$PWD
ln -srf ./ohmyzsh/lib/common_config.zsh $HOME/.oh-my-zsh/lib/common_config.zsh
cd $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git pull
cd $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git pull
cd $CURRENTDIR



