#!/bin/sh


# Checks if the file already exists
function check_file_exists() {
	if [ -f "$1" ]; then
		echo "File $1 already exists"
		exit 1
	fi
}


# Checks if the user have rights on the file
function check_file_rights() {
	if [ ! -w "$1" ]; then
		echo "You don't have rights on the file $1"
		exit 1
	fi
}


# Checks if the argument is empty
function check_argument() {
	if [ -z "$2" ]; then
		echo "$1 is empty"
		exit 1
	fi
}


# Main function
argsAndValues=( "$@" )
fileName=""
description=""

if [ $# -eq 0 ];
then
  echo "No arguments provided"
  exit 1
else
  for ((i = 0; $[2 * i] < $#; i++ )); do 
    case ${argsAndValues[$[2 * i]]} in
	  --create-html)
		check_argument "${argsAndValues[$[2 * i]]}" "${argsAndValues[$[2 * i + 1]]}"
		fileName="${argsAndValues[$[2 * i + 1]]}.html"
		check_file_exists "$fileName"
		check_file_rights "$fileName"
		touch "$fileName"
		;;
	  --update-charset)
		echo "--update-charset"
		echo "${argsAndValues[$[2 * i + 1]]}"
		;;
	  --update-title)
	  	echo "--update-title"
		echo "${argsAndValues[$[2 * i + 1]]}"
		;;
	  --update-description)
	  	check_argument "${argsAndValues[$[2 * i]]}" "${argsAndValues[$[2 * i + 1]]}"
	  	description="${argsAndValues[$[2 * i + 1]]}"
		check_file_exists "$fileName"
		check_file_rights "$fileName"
		;;
	  --add-stylesheet)
	  	echo "--add-stylesheet"
		echo "${argsAndValues[$[2 * i + 1]]}"
		;;
	  --add-script)
	  	echo "--add-script"
		echo "${argsAndValues[$[2 * i + 1]]}"
		;;
	  *)
		echo "Unknown argument ${argsAndValues[$[2 * i]]}"
		exit 1
		;;
    esac
  done
fi
