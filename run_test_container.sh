#!/usr/bin/env bash

dotfiles_zip_name="dotfiles.fish.zip"
image_name='dotfiles_test_image'
container_name='dotfiles_test_container'

if [[ "$1" == "--with-build" ]]; then
    docker build -t $image_name . || exit $?
fi

docker rm -vf $container_name
docker run -itd --name $container_name $image_name || exit $?

rm $dotfiles_zip_name
zip -r $dotfiles_zip_name ../dotfiles.fish/
docker cp $dotfiles_zip_name $container_name:/home/tonango/
docker exec $container_name bash -c "unzip $dotfiles_zip_name; rm -f $dotfiles_zip_name"

docker exec -it $container_name env TERM=xterm-256color /usr/bin/fish
