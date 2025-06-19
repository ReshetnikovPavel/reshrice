#!/bin/bash

set -e

function prompt {
	read -p "$1 [y/n] " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
		$2
	fi
}

function install {
	echo 'Updating the system'
	sudo pacman -Syu
	echo 'Installing git and base-devel'
	sudo pacman -S git base-devel
	install_yay
}

function install_yay {
	if ! command -v yay &> /dev/null; then
		echo "Installing yay AUR helper..."
		sudo pacman -S --needed git base-devel --noconfirm
		if [[ ! -d "yay" ]]; then
			echo "Cloning yay repository..."
		else
			echo "yay directory already exists, removing it..."
			rm -rf yay
		fi

		git clone https://aur.archlinux.org/yay.git

		cd yay
		echo "building yay.... yaaaaayyyyy"
		makepkg -si --noconfirm
		cd ..
		rm -rf yay
	else
		echo "yay is already installed"
	fi
}


echo 'Welcome to reshrice installer!'
prompt 'Shall we start the installation process?' install
