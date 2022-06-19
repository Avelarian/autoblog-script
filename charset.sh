#!/bin/bash


if [ "$1" = "--update-charset" ]; then

	#Check if encoding is empty
	if [ -z "$2" ]; then
		echo "Error: encoding is empty"
	else    
		ENCODING=$2
	fi

	#Check if filename is empty
	if [ -z "$3" ]; then
    echo "Error: filename is empty"
	else    
    FILENAME=$3
  fi

	#Rights checks  
  if [ ! -w "$FILENAME" ]; then
    echo "Error: not permission"
  fi


	#Update charset if there are any one
	if  grep -q "meta charset" $FILENAME; then
    sed -i "s/<meta charset=\".*\" \/>/<meta charset=\"$ENCODING\" \/>/g" $FILENAME
    
  #Insert a meta tag if there are no one    
  else
    sed -i 'i\<head><meta charset="'$ENCODING'" \/><\/head>' $FILENAME
		
	fi
	
	exit 0


else
	echo "Usage: charset.sh --update-charset ENCODING FILENAME"
fi
