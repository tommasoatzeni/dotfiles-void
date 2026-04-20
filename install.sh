#!/bin/sh
DOTFILES="$(dirname "$(realpath "$0")")"

cp "$DOTFILES/home/.bashrc"   ~/.bashrc
cp "$DOTFILES/home/.tmux.conf" ~/.tmux.conf
cp "$DOTFILES/home/.vimrc"    ~/.vimrc
sudo cp "$DOTFILES/etc/rc.conf" /etc/rc.conf
sudo mkdir -p /etc/dnsmasq.d
sudo cp "$DOTFILES/etc/dnsmasq.d/lab.conf" /etc/dnsmasq.d/lab.conf

echo "Dotfiles installati."
