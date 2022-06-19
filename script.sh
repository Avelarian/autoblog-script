#!/bin/sh

# Checks if the file already exists
function check_file_exists() {
	if [ -f "$1" ]; then
		echo "File $1 already exists"
		exit 1
	fi
}

# Checks if file does not exists
function check_file_does_not_exist() {
	if [ ! -f "$1" ]; then
		echo "File $1 does not exist"
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

# Checks secondary arguments
function check_secondary_arguments() {
	check_argument "$1" "$2"
	check_argument 'fileName' "$3"

	check_file_does_not_exist "$3"
	check_file_rights "$3"
}


# Main function
if [ $# -eq 0 ];
then
	echo "No arguments provided"
	exit 1
else
	if [ "$1" = "--create-html" ];
	then
		check_argument "$1" "$2"
    	check_file_exists "$2"

		fileName="$2.html"
		touch $fileName
		check_file_rights $fileName

		cat <<- EOF > $fileName
		<!DOCTYPE html>
		<html>
		  <head>
		    <title>Document title</title>
			<meta name="description" content="Document description">
			<meta charset="UTF-8">
		  </head>
		  <body>
		    <h1>Hello, World!</h1>
		  </body>
		</html>
		EOF
  	else
    	argsAndValues=( "$@" )
		fileNameAlredyExists=""
		charset=""
		description=""
		title=""
		stylesheetUrl=""
		scriptUrl=""

		for ((i = 0; i < $#; i++ )); do 
      		case ${argsAndValues[$i]} in
	    		--update-charset)
					check_secondary_arguments "${argsAndValues[$i]}" "${argsAndValues[$i+1]}" "${argsAndValues[$i+2]}"
					charset="${argsAndValues[$i+1]}"

					if grep -q "charset" ${argsAndValues[$i+2]}; then
    					#replace description meta tag
    					sed -i "s/<meta charset=\".*\" \/>/<meta charset=\"$charset\" \/>/g" ${argsAndValues[$i+2]}
  					else
    					#add description meta tag
    					sed -i "s/<\/head>/<meta charset=\"$charset\" \/>\n<\/head>/g" ${argsAndValues[$i+2]}
  					fi
				--update-title)
				  	check_secondary_arguments "${argsAndValues[$i]}" "${argsAndValues[$i+1]}" "${argsAndValues[$i+2]}"
					title="${argsAndValues[$i+1]}"

					if grep -q "title" ${argsAndValues[$i+2]}; then
    					#replace description meta tag
    					sed -i "s/<title>\".*\"\/><\/title>/<title>\"$title\"<\/title>/g" ${argsAndValues[$i+2]}
  					else
    					#add description meta tag
    					sed -i "s/<\/head>/<meta charset=\"$charset\" \/>\n<\/head>/g" ${argsAndValues[$i+2]}
  					fi
				--update-description)
					check_secondary_arguments "${argsAndValues[$i]}" "${argsAndValues[$i+1]}" "${argsAndValues[$i+2]}"
					description="${argsAndValues[$i+1]}"

					if grep -q "description" ${argsAndValues[$i+2]}; then
    					#replace description meta tag
    					sed -i "s/<meta name=\"description\" content=\".*\" \/>/<meta name=\"description\" content=\"$description\" \/>/g" ${argsAndValues[$i+2]}
  					else
    					#add description meta tag
    					sed -i "s/<\/head>/<meta name=\"description\" content=\"$description\" \/>\n<\/head>/g" ${argsAndValues[$i+2]}
  					fi
				--add-stylesheet)
				  	check_secondary_arguments "${argsAndValues[$i]}" "${argsAndValues[$i+1]}" "${argsAndValues[$i+2]}"
				--add-script)
				  	check_secondary_arguments "${argsAndValues[$i]}" "${argsAndValues[$i+1]}" "${argsAndValues[$i+2]}"
	    		*)
	  				echo "Unknown argument ${argsAndValues[$[2 * i]]}"
	  				exit 1
	  				;;
      		esac
  		done
  	fi
fi
