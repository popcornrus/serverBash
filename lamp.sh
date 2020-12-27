#!/bin/bash
clear
printf "Menu LAMP:\n\n"

menu=([1]="Install lamp packages" [2]="Add new domain" [3]="Backup files" [4]="Backup DB"
)


for index in ${!menu[*]}; do
	echo "$index. ${menu[$index]}"
done

printf "Write here menu point (ex. 3): "
read -p menuPoint

bash menu[menuPoint]["file"]
