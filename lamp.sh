#!/bin/bash
clear
printf "Menu LAMP:\n\n"

menu=([1]="Install lamp packages" [2]="Domains" [3]="Backup files" [4]="Backup DB")

files=([1]="./scripts/sh/install.sh" [2]="./scripts/sh/domains.sh")


for index in ${!menu[*]}; do
	echo "$index. ${menu[$index]}"
done

printf "Write here menu point (ex. 3): "
read menuPoint

bash "${files[menuPoint]}"
