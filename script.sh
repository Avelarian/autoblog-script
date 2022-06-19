#!/bin/sh


# Checks if the file already exists thanks to the second argument given
if [ -e "$2" ]; then

  echo "Error: Already exist"

  else

    FILENAME=$2
    touch "$FILENAME"

fi


# Checks if the user have rights on the file
if [ ! -w "$2" ]; then

  echo "Error: You don't have the right to modify this file"

fi


# Checks if the filename is empty
if [ -z "$2" ]; then

    echo "Error: Filename is empty"

fi


# If the first argument is given the script create an another file which contain an HTML structure
if  [ "$1" = "--create-html" ]; then
    echo '<!DOCTYPE html>
          <html lang="fr">
            <head>
              <meta charset="utf-8" />
              <title>Titre de la page</title>
              <link rel="stylesheet" href="style.css" />
            </head>
            <body></body>
          </html>' > ./$2;

          echo "Success : The file has been created"

fi