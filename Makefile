DOTFILES_ZIP   := dotfiles.fish.zip
TEST_IMAGE     := dotfiles_test_image
TEST_CONTAINER := dotfiles_test_container

.PHONY: deploy
deploy: prerequisite fzf symlink fisher vim after-all

.PHONY: after-all
after-all:
	@printf "\n"
	@printf "\033[32m%s\033[m\n" "dotfiles.fish's deployment is completed."
	@printf "\033[32m%s\033[m\n" "Please run 'exec fish -l'."

.PHONY: prerequisite
prerequisite:
	command -v fish git curl vim > /dev/null 2>&1

.PHONY: fzf
fzf:
	rm -rf ~/.fzf
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install --all --no-bash --no-zsh

.PHONY: symlink
symlink:
	./installer/symlink_installer.sh

.PHONY: fisher
fisher:
	fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update"

.PHONY: vim
vim:
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	vim +PlugInstall +qa

.PHONY: homebrew
homebrew:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

.PHONY: brew
brew:
	brew bundle --file Brewfile

.PHONY: update-completion
update-completion:
	mkdir -p symlink/common/.config/fish/completions
	curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/fish/docker.fish \
		-o symlink/common/.config/fish/completions/docker.fish
	curl https://raw.githubusercontent.com/docker/compose/master/contrib/completion/fish/docker-compose.fish \
		-o symlink/common/.config/fish/completions/docker-compose.fish

.PHONY: docker-zip-dotfiles
docker-zip-dotfiles:
	rm -vf $(DOTFILES_ZIP)
	zip -r $(DOTFILES_ZIP) ../dotfiles.fish/ -x "*.git*"

.PHONY: docker-build
docker-build:
	docker build -t $(TEST_IMAGE) .

.PHONY: docker-run
docker-run: docker-zip-dotfiles docker-build
	docker rm -vf $(TEST_CONTAINER)
	docker run -itd --name $(TEST_CONTAINER) $(TEST_IMAGE)
	docker cp $(DOTFILES_ZIP) $(TEST_CONTAINER):/home/tonango/
	docker exec $(TEST_CONTAINER) bash -c "unzip $(DOTFILES_ZIP); rm -f $(DOTFILES_ZIP)"
	docker exec -it $(TEST_CONTAINER) env TERM=xterm-256color /usr/bin/fish
