.PHONY: all
all: brew symlink fisher vim relogin

.PHONY: brew
brew:
	./installer/brew_installer.sh

.PHONY: symlink
symlink:
	./installer/symlink_installer.sh

.PHONY: fisher
fisher:
	./installer/fisher_installer.sh

.PHONY: vim
vim:
	./installer/vim_installer.sh

.PHONY: relogin
relogin:
	exec fish -l

