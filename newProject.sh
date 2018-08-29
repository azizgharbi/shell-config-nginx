#!/bin/bash

#read the file name
read -p "Enter your file configuration name: " name
name=${name:-wp-default}
echo "project name choosen is " $name
#read the domaine name

read -p "Enter your domaine: " domaine
domaine=${domaine:-localhost.default.com}
set ver
echo 'Please enter your php version: '
options=("php5.6" "php7.0" "php7.1" "php7.2" "Quit")

select opt in "${options[@]}"
do
    case $opt in
        "php5.6")
            echo "your choice is ${options[0]}"
            ver="${options[0]}"
            break
            ;;
        "php7.0")
            echo "your choice is ${options[1]}"
            ver="${options[1]}" 
            break
            ;;
        "php7.1")
            echo "your choice is ${options[2]}"
            ver="${options[2]}" 
            break
            ;;
        "php7.2")
            echo "your choice is ${options[3]}"
            ver="${options[3]}" 
            break
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done

sed -i -e "s/domain_name/$domaine/g" default.conf
sed -i -e "s/php_version/$ver/g" default.conf
sed -i -e "s/projet_name/$name/g" default.conf


cp default.conf "/etc/nginx/sites-available/$name"

sed -i -e "s/$domaine/domain_name/g" default.conf
sed -i -e "s/$ver/php_version/g" default.conf
sed -i -e "s/$name/projet_name/g" default.conf


ln -s "/etc/nginx/sites-available/$name" "/etc/nginx/sites-enabled/$name"

service nginx restart
