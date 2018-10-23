#!/bin/bash
echo "Hello User!"
echo "Give me your username"
read USERNAME
if [ "$USERNAME" != "bye" ] && [ "$USERNAME" != "quit" ]; then
  echo "Give me your first and last name"
  read NAME
  for i in 1 2 3 4 5
  do
    echo "${NAME}" > "${USERNAME}${i}.txt"
  done
  echo "Give me a filename"
  read FILENAME
  while [ -f "$FILENAME" ]
  do
    echo "This file already exists. Please give another filename"
    read FILENAME
  done
  ls ${USERNAME}* > "${FILENAME}"  
fi

