DOTFILES_ZIP   := dotfiles.fish.zip
TEST_IMAGE     := dotfiles_test_image
TEST_CONTAINER := dotfiles_test_container

.PHONY: deploy
deploy: fzf symlink fisher vim

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
	./installer/fisher_installer.sh

.PHONY: vim
vim:
	./installer/vim_installer.sh

.PHONY: homebrew
homebrew:
	./installer/homebrew_installer.sh

.PHONY: brew
brew:
	./installer/brew_installer.sh

.PHONY: docker-update-completion
docker-update-completion:
	mkdir -p symlink/common/.config/fish/completions
	curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/fish/docker.fish \
		-o symlink/common/.config/fish/completions/docker.fish
	curl https://raw.githubusercontent.com/docker/compose/master/contrib/completion/fish/docker-compose.fish \
		-o symlink/common/.config/fish/completions/docker-compose.fish

.PHONY: docker-zip-dotfiles
docker-zip-dotfiles:
	rm -vf $(DOTFILES_ZIP)
	zip -r $(DOTFILES_ZIP) ../dotfiles.fish/

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
