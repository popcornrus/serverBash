#!/bin/bash

showMenu() {
	clear
	printf "Menu Domains:\n"
	printf "1. Domains list\n"
	printf "2. Create new Domain\n"
	printf "3. Delete domain\n"
	printf "4. Exit\n\n"

	read -p "Please select a number: " menuPoint
	return "${menuPoint}"
}

showMenu
m=$?

while [[ "${m}" != "4" ]]; do
	clear
	if [[ "${m}" == "1" ]]; then
		printf "\n\nList of Domains:\n\n"
		node scripts/js/domains/listDomains.js
	fi

	if [[ "${m}" == "2" ]]; then
		printf "\n\nList of Domains:\n\n"
		bash scripts/sh/domains/newDomain.sh
	fi

	printf "\n\n\n\n"
	read -p "Press Enter to go back ..."
	showMenu
	m=$?
done

exit