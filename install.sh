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
	echo 'Installing git'
	sudo pacman -S git
}


echo 'Welcome to reshrice installer!'
prompt 'Shall we start the installation process?' install
