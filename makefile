.PHONY: kitty clean-kitty vim clean-vim tmux clean-tmux tmux-tpm zsh zsh-plugins oh-my-zsh update-zsh-plugins clean-zsh alacritty
kitty:
	stow --verbose --target=$(HOME) kitty

clean-kitty:
	stow --verbose --target=$(HOME) --delete kitty

vim:
	stow --verbose --target=$(HOME) nvim

clean-vim:
	stow --verbose --target=$(HOME) --delete nvim

tmux:
	stow --verbose --target=$(HOME) tmux

clean-tmux:
	stow --verbose --target=$(HOME) --delete tmux

tmux-tpm:
	mkdir -p ~/.tmux/plugins && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

zsh:
	stow --verbose --target=$(HOME)/.oh-my-zsh/lib zsh

clean-zsh:
	stow --verbose --target=$(HOME)/.oh-my-zsh/lib --delete zsh

oh-my-zsh:
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \

zsh-plugins:
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $(HOME)/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting \
		&& git clone https://github.com/zsh-users/zsh-autosuggestions $(HOME)/.oh-my-zsh/custom/plugins/zsh-autosuggestions \
		&& git clone https://github.com/marlonrichert/zsh-autocomplete $(HOME)/.oh-my-zsh/custom/plugins/zsh-autocomplete	

update-zsh-plugins:
		git -C $(HOME)/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting pull \
		&& git -C $(HOME)/.oh-my-zsh/custom/plugins/zsh-autosuggestions pull \
		&& git -C $(HOME)/.oh-my-zsh/custom/plugins/zsh-autocomplete pull

alacritty:
	stow --verbose --target=$(HOME) alacritty
