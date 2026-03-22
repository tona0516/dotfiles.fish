FROM debian:stable-slim
LABEL maintainer="tona0516 <tonango.0516@gmail.com>"

ARG USER="tona0516"
ARG DOTFILES="dotfiles.fish"

# 環境を更新し、必要なパッケージをインストール
RUN apt update && apt install -y \
    passwd \
    sudo \
    make \
    curl \
    vim \
    less \
    git \
    fish \
    && rm -rf /var/lib/apt/lists/*

# ユーザー tona0516 を作成し、パスワードを設定
RUN useradd -m -s /bin/bash ${USER} \
    && echo "${USER}:0000" | chpasswd

# sudo 権限を付与
RUN usermod -aG sudo ${USER}

# デフォルトのユーザーを変更
USER ${USER}

# 作業ディレクトリを設定
WORKDIR /home/${USER}/${DOTFILES}
