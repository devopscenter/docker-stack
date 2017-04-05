#!/bin/bash -ev
sudo apt-get -qq update && sudo apt-get -qq -y install python-software-properties software-properties-common && \
    sudo add-apt-repository "deb http://gb.archive.ubuntu.com/ubuntu $(lsb_release -sc) universe" && \
    sudo add-apt-repository -yu ppa:pi-rho/dev  && \
    sudo apt-get -qq update

sudo add-apt-repository -y ppa:saiarcot895/myppa && \
    sudo apt-get -qq update && \
    sudo DEBIAN_FRONTEND=noninteractive apt-get -qq -y install apt-fast

sudo apt-fast -qq -y install git wget sudo vim unzip curl language-pack-en

sudo apt-fast -y install ncdu ntp fail2ban htop

sudo apt-fast -y install tmux-next
sudo mv /usr/bin/tmux-next /usr/bin/tmux

pushd /tmp
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
popd

echo unattended-upgrades unattended-upgrades/enable_auto_updates boolean true | sudo debconf-set-selections
sudo apt-fast -y install unattended-upgrades

pushd $HOME
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tmux-pain-control ~/.tmux/plugins/tmux-pain-control
git clone https://github.com/tmux-plugins/tmux-yank ~/.tmux/plugins/tmux-yank
popd

pushd ~/dcStack/buildtools/utils
cp tmux.conf $HOME/.tmux.conf
cp bash_profile $HOME/.bash_profile
cp bashrc $HOME/.bashrc
popd
