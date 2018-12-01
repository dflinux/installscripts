#!/bin/bash

function strap() {
	OLD_IFS=$IFS
	IFS=$'\n'
	packages=""
	for line in $(cat "./${d}"); do
		packages="${packages} ${line}"
	done
	IFS=$OLD_IFS

	printf "Installing ${d}...\n"
	pacman -S --needed --noconfirm${packages} >/dev/null 2>&1
}

function showtitle(){
	clear
	cat ./title
	read -p ""
}

function showdone(){
	echo "----------------"
	echo "      DONE"
	echo "----------------"

}

function checkifroot(){
	if [[ $EUID -ne 0 ]]; then
		echo "The installer must be run as root"
		exit 1
	fi
}

function main(){
	checkifroot
	showtitle
	for d in xorg xfce apps audio displaymanager fonts network themes
	do
		strap d
	done
	showdone
}

main $0