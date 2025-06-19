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

function install_all {
	echo 'Updating the system'
	sudo pacman -Syu
	install_yay
	install_and_setup_hyprland 
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

function install_and_setup_hyprland {
	echo "Installing Hyprland with uwsm"
	sudo pacman -S --needed hyprland uwsm libnewt --noconfirm
}


echo 'Welcome to reshrice installer!'
prompt 'Shall we start the installation process?' install_all
