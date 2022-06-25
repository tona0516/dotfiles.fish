DOTFILES_ZIP := dotfiles.fish.zip
TEST_IMAGE := dotfiles_test_image
TEST_CONTAINER := dotfiles_test_container

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
