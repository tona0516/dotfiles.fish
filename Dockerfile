FROM debian:bookworm-slim
LABEL maintainer="tona0516 <tonango.0516@gmal.com>"

ARG USER="tona0516"

# 環境を更新し、必要なパッケージをインストール
RUN apt-get update && apt-get install -y \
    passwd \
    sudo \
    curl \
    vim \
    less \
    git \
    && rm -rf /var/lib/apt/lists/*

# ユーザー tona0516 を作成し、パスワードを設定
RUN useradd -m -s /bin/bash ${USER} \
    && echo "${USER}:0000" | chpasswd

# sudo 権限を付与（必要なら）
RUN usermod -aG sudo ${USER}

# デフォルトのユーザーを変更（必要なら）
USER ${USER}

# 作業ディレクトリを設定（必要なら）
WORKDIR /home/${USER}
