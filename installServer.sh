#!/bin/bash

# Colors
ERROR="\033[0;31m"
SUCCESS="\033[0;32m"
NC="\033[0;0m"

if [ "$(whoami)" != 'root' ]; then
	printf "${ERROR}You need to sign in as Root user: sudo {file}\n"
	exit
fi

printf "Install all packages? (y/n): "
read installAll

if [[ "${installAll}" == 'y' ]]; then
	printf "Update packages list: "
	if "$(apt update)"; then
		printf "${SUCCESS}Success${NC}"
	fi
fi
