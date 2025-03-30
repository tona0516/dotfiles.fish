TEST_IMAGE     := dotfiles_test_image
TEST_CONTAINER := dotfiles_test_container
DOTFILES  := dotfiles.fish

#----------------------------------------
# Test commands
#----------------------------------------
.PHONY: docker-build
docker-build:
	docker build -t $(TEST_IMAGE) .

.PHONY: docker-run
docker-run: docker-build
	docker rm -vf $(TEST_CONTAINER)
	docker run -itd --name $(TEST_CONTAINER) $(TEST_IMAGE)
	docker cp ../$(DOTFILES) $(TEST_CONTAINER):/home/tona0516/
	docker exec -it -u 0 $(TEST_CONTAINER) chown -R tona0516:tona0516 /home/tona0516/$(DOTFILES)

.PHONY: docker-exec
docker-exec:
	docker exec -it $(TEST_CONTAINER) env TERM=xterm-256color /usr/bin/fish

.PHONY: test
test: docker-run docker-exec
