.PHONY: kitty clean-kitty vim clean-vim tmux clean-tmux
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

