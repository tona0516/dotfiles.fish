# image settings
FROM amd64/ubuntu:22.04
LABEL maintainer="tona0516 <tonango.0516@gmail.com>"

# package settings
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y sudo fish vim language-pack-ja-base language-pack-ja locales curl git gcc zip make

# user settings
RUN useradd -m tonango && echo "tonango:password" | chpasswd && adduser tonango sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# locale settings
RUN locale-gen ja_JP.UTF-8
RUN echo "export LANG=ja_JP.UTF-8" >> /home/tonango/.profile

# dotfiles settings
COPY --chown=tonango:tonango install_brew.sh /home/tonango/install_brew.sh

USER tonango
WORKDIR /home/tonango

# install brew command
RUN bash install_brew.sh

