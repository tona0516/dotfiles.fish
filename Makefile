TEST_IMAGE     := dotfiles_test_image
TEST_CONTAINER := dotfiles_test_container
DOTFILES_NAME  := dotfiles.fish
DOTFILES_ZIP   := $(DOTFILES_NAME).zip

CYAN_BOLD := \033[1;36m
NC        := \033[0m

#----------------------------------------
# Test commands
#----------------------------------------
.PHONY: docker-build
docker-build:
	@printf "$(CYAN_BOLD)%s$(NC)\n" "$@:"
	docker build -t $(TEST_IMAGE) .

.PHONY: docker-run
docker-run: docker-build
	@printf "$(CYAN_BOLD)%s$(NC)\n" "$@:"
	docker rm -vf $(TEST_CONTAINER)
	docker run -itd --name $(TEST_CONTAINER) $(TEST_IMAGE)

.PHONY: docker-exec
docker-exec:
	@printf "$(CYAN_BOLD)%s$(NC)\n" "$@:"
	docker exec -it $(TEST_CONTAINER) env TERM=xterm-256color /bin/bash

.PHONY: test
test: docker-run docker-exec
	@printf "$(CYAN_BOLD)%s$(NC)\n" "$@:"

