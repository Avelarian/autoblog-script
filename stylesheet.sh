#!/bin/bash


if [ "$1" = "--add-stylesheet" ]; then

	#check if url is empty
	if [ -z "$2" ]; then
		echo "Error: url is empty"
	else    
		URL=$2
	fi

	#Check if filename is empty
	if [ -z "$3" ]; then
		echo "Error: filename is empty"
	else    
    		FILENAME=$3
  	fi
	
	#Check if the url is correct
	if [ ! -f "$URL" ]; then
	  echo "Error: url doesn't exist"
	fi

	# rights checks  
  	if [ ! -w "$FILENAME" ]; then
		echo "Error: not permission"
	fi


	#Insert link tag if there are not a link tag 
	if ! grep -q "<link>" $FILENAME; then
		sed -i 'i\<head> <link rel="stylesheet" href="'$URL'"> ' $FILENAME	
	fi
	
	exit 0


else
	echo "Usage: stylesheet.sh --add-stylesheet URL FILENAME"
fi
