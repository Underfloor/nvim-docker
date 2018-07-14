FROM ubuntu:18.04

MAINTAINER Antoine CHARMOIS

ENV TERM screen-256color
ENV DEBIAN_FRONTEND noninteractive

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ENV NVM_VERSION 0.33.11
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 8.11.3

RUN apt-get -y update
RUN apt-get -y install \
	curl \
	git \
	exuberant-ctags \
	software-properties-common \
	python-dev \
	python-pip \
	python3-dev \
	python3-pip

RUN add-apt-repository ppa:neovim-ppa/stable
RUN apt-get -y update
RUN apt-get -y install \
	neovim

RUN pip2 install --user setuptools
RUN pip3 install --user setuptools

WORKDIR /root
RUN git clone https://github.com/neovim/python-client.git
WORKDIR /root/python-client
RUN pip2 install --user .
RUN pip3 install --user .
WORKDIR /root
RUN rm -rf python-client

RUN mkdir $NVM_DIR

RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v${NVM_VERSION}/install.sh | bash
RUN source $NVM_DIR/nvm.sh \
	&& nvm install $NODE_VERSION \
	&& nvm alias default $NODE_VERSION \
	&& nvm use default \
	&& npm i -g npm typescript tslint neovim git+https://github.com/Perlence/tstags.git

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

ADD init.vim /root/.config/nvim/init.vim

RUN curl --silent -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ADD nvim-typescript.ts /root/nvim-typescript.ts
RUN nvim -i NONE -c PlugUpgrade -c PlugInstall! -c UpdateRemotePlugins -c quitall 2>&1 >/dev/null
RUN nvim -i NONE -c e /root/nvim-typescript.ts -c UpdateRemotePlugins -c quitall 2>&1 >/dev/null
RUN rm /root/nvim-typescript.ts

RUN apt-get -y autoclean
RUN apt-get -y autoremove
