#!/bin/bash

# Setup script for new Kali linux installs.
# There are just some of my preferred tools, options, etc.


apply_system_updates() {
    echo 'Applying system updates...'
    apt-get update
    apt-get upgrade -y
    apt-get dist-upgrade -y
    apt-get autoremove -y
}

install_packages() {
    echo 'Installing additional packages.'
    apt-get install -y \
        gobuster \
        impacket-* \
        libpng-dev
    # Nokogiri gem install fails when attempting to install Fingerprinter.
    # This reconfigures the software required for the install to pass.
    apt-get install -y \
        --reinstall \
        zlibc \
        zlib1g \
        zlib1g-dev
}

install_from_git() {
    echo 'Downloading software from github.'
    cd /opt
    git clone https://github.com/danielmiessler/SecLists.git
    git clone https://github.com/rebootuser/LinEnum.git
    git clone https://github.com/PowerShellMafia/PowerSploit.git
    git clone https://github.com/erwanlr/Fingerprinter.git
    cd Fingerprinter
    gem install bundler
    bundle install
    cd ../
}

create_configs() {
    echo 'Creating bash aliases.  This will replace your ~/.bash_aliases file'
    cp ./.tmux.conf ~/
    cp ./.bash_aliases ~/
    source ~/.bash_aliases
}

create_dirs() {
    echo 'Creating a couple directories that I typically use...'
    mkdir -p ~/htb
    mkdir -p ~/dev
}

cleanup() {
    apt-get autoremove -y
}

create_configs
apply_system_updates
install_packages
install_from_git
create_dirs
cleanup
