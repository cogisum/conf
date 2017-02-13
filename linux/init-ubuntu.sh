#!/bin/bash

set -e

usage() {
    echo "Usage: `basename $0` USER [PUB_KEY]"
}

user=$1
pub_key="$2"

continue_or_exit() {
    local msg="$1"
    echo "$msg, press Y/y to continue: " 
    read -n1 rsp
    if [ "x$rsp" != xY -a "x$rsp" != xy ]; then
        exit 2
    fi
}

if [ -z "$user" ]; then
    usage
    exit 1
fi
if [ -z "$pub_key" ]; then
    continue_or_exit "Warning: no pub key"
fi

# create user account
if [ -n $user ]; then
    useradd -m -s /bin/bash $user
    passwd $user
    usermod -aG sudo $user
fi

# install packages
apt update
apt install -y vim
apt install -y tmux
apt install -y trash-cli
apt install -y git

export pub_key
su - $user -w pub_key -c '
# ssh key
if [ -n "$pub_key" ]; then
    mkdir ~/.ssh
    chmod 700 ~/.ssh
    echo "$pub_key" >>~/.ssh/authorized_keys
    chmod 600 ~/.ssh/authorized_keys
fi

# install packages and init
conf_repo_url="https://raw.githubusercontent.com/cogisum/conf/master"

## bash
curl $conf_repo_url/bash/append.bashrc >>~/.bashrc

## vim
curl $conf_repo_url/vim/mini.vimrc -o ~/.vimrc

## tmux
curl $conf_repo_url/tmux/.tmux.conf -o ~/.tmux.conf
'

# disable root login and password login
# make this file first in case there're other files that conflict
my_sshd_config=/etc/ssh/sshd_config.d/00-my.conf
echo "PasswordAuthentication no" >>$my_sshd_config
systemctl restart sshd
