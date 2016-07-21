FROM ubuntu:16.04

ENV CUSTOM_SCRIPTS_DIR=/custom-scripts.d
ENV PROJECT_DIR=/Projects

# Dependencies
RUN apt-get update
RUN apt-get install -y python python-dev python3 python3-dev git build-essential make ncurses-dev python-pip byobu curl
RUN pip install --upgrade pip
RUN pip install tox flake8

# Vim
WORKDIR /tmp
RUN git clone https://github.com/vim/vim.git
WORKDIR /tmp/vim/src
RUN ./configure --enable-perlinterp --enable-pythoninterp --enable-python3interp --enable-rubyinterp --enable-cscope --enable-gui=auto --enable-gtk2-check --enable-gnome-check --with-features=huge --enable-multibyte --with-x --with-compiledby="Senor QA <senor@qa>" --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu --with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu
RUN make
RUN make install
RUN git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
COPY inputrc /root/.inputrc
COPY vimrc /root/.vimrc
RUN vim +PluginInstall +qall
RUN ln -s /usr/local/bin/vim  /usr/local/bin/vi

RUN echo "alias activate-project-virtualenv-27='. \$(pwd)/.tox/py27/bin/activate'" >> /root/.bashrc
RUN echo "alias activate-project-virtualenv-35='. \$(pwd)/.tox/py35/bin/activate'" >> /root/.bashrc

RUN mkdir -p $CUSTOM_SCRIPTS_DIR
RUN mkdir -p $PROJECT_DIR
VOLUME $CUSTOM_SCRIPTS_DIR
VOLUME $PROJECT_DIR
WORKDIR $PROJECT_DIR

COPY entrypoint.sh /usr/local/bin
ENTRYPOINT  ["/bin/bash", "entrypoint.sh"]
