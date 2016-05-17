FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y python python-dev python3 python3-dev git build-essential make ncurses-dev python-pip byobu
RUN pip install --upgrade pip
RUN pip install virtualenv flake8

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

COPY entrypoint.sh /tmp

VOLUME /Project
VOLUME /root/.ssh

WORKDIR /Project

ENTRYPOINT ["/tmp/entrypoint.sh"]
