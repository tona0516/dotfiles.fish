TEST_IMAGE     := dotfiles_test_image
TEST_CONTAINER := dotfiles_test_container
DOTFILES_ZIP   := dotfiles.fish.zip

GREEN     := \033[0;32m
CYAN_BOLD := \033[1;36m
NC        := \033[0m

.PHONY: deploy
deploy: \
	check-prerequisite \
	create-symlink \
	install-fzf \
	install-fish-plugin \
	install-vim-plugin \
	complete \

.PHONY: complete
complete:
	@printf "$(CYAN_BOLD)%s$(NC)\n" "$@:"
	@printf "$(GREEN)%s$(NC)\n" "dotfiles.fish's deployment is completed."
	@printf "$(GREEN)%s$(NC)\n" "Please run 'exec fish -l'."

.PHONY: check-prerequisite
check-prerequisite:
	@printf "$(CYAN_BOLD)%s$(NC)\n" "$@:"
	command -v fish > /dev/null 2>&1
	command -v git > /dev/null 2>&1
	command -v curl > /dev/null 2>&1
	command -v vim > /dev/null 2>&1

.PHONY: install-fzf
install-fzf:
	@printf "$(CYAN_BOLD)%s$(NC)\n" "$@:"
	rm -rf ~/.fzf
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install --all --no-bash --no-zsh

.PHONY: create-symlink
create-symlink:
	@printf "$(CYAN_BOLD)%s$(NC)\n" "$@:"
	./symlink_installer.fish

.PHONY: install-fish-plugin
install-fish-plugin:
	@printf "$(CYAN_BOLD)%s$(NC)\n" "$@:"
	fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update"

.PHONY: install-vim-plugin
install-vim-plugin:
	@printf "$(CYAN_BOLD)%s$(NC)\n" "$@:"
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	vim +PlugInstall +qa

.PHONY: install-homebrew
install-homebrew:
	@printf "$(CYAN_BOLD)%s$(NC)\n" "$@:"
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

.PHONY: install-brew-package
install-brew-package:
	@printf "$(CYAN_BOLD)%s$(NC)\n" "$@:"
	brew bundle --file Brewfile

.PHONY: update-completion
update-completion:
	@printf "$(CYAN_BOLD)%s$(NC)\n" "$@:"
	mkdir -p symlink/common/.config/fish/completions
	curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/fish/docker.fish \
		-o symlink/common/.config/fish/completions/docker.fish
	curl https://raw.githubusercontent.com/docker/compose/master/contrib/completion/fish/docker-compose.fish \
		-o symlink/common/.config/fish/completions/docker-compose.fish

.PHONY: zip-dotfiles
zip-dotfiles:
	@printf "$(CYAN_BOLD)%s$(NC)\n" "$@:"
	rm -vf $(DOTFILES_ZIP)
	zip -r $(DOTFILES_ZIP) ../dotfiles.fish/ -x "*.git*"

.PHONY: build-docker-image
build-docker-image:
	@printf "$(CYAN_BOLD)%s$(NC)\n" "$@:"
	docker build -t $(TEST_IMAGE) .

.PHONY: run-docker-container
run-docker-container: zip-dotfiles build-docker-image
	@printf "$(CYAN_BOLD)%s$(NC)\n" "$@:"
	docker rm -vf $(TEST_CONTAINER)
	docker run -itd --name $(TEST_CONTAINER) $(TEST_IMAGE)
	docker cp $(DOTFILES_ZIP) $(TEST_CONTAINER):/home/tona0516/
	docker exec $(TEST_CONTAINER) bash -c "unzip $(DOTFILES_ZIP); rm -f $(DOTFILES_ZIP)"
	docker exec -it $(TEST_CONTAINER) env TERM=xterm-256color /usr/bin/fish
