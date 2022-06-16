#!/bin/sh


if [ -e "$2" ]; then

  echo "Error: Already exist"

  else

    FILENAME=$2
    touch "$FILENAME"

fi

if [ ! -w "$2" ]; then

  echo "Error: You don't have the right to modify this file"

fi

if [ -z "$2" ]; then

    echo "Error: Filename is empty"

fi


if  [ "$1" = "--create-html" ]; then
    echo '<!DOCTYPE html>
          <html lang="fr">
            <head>
              <meta charset="utf-8" />
              <title>Titre de la page</title>
              <link rel="stylesheet" href="style.css" />
            </head>
            <body></body>
          </html>' > ./$2

fi