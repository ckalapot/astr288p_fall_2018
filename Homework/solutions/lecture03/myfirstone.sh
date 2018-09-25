#!/bin/bash
echo "Hello user!"
echo "Give me your name"
read FNAME
echo "${FNAME}, give me your last name"
read LNAME
echo "${FNAME}, give me your user name"
read UNAME
echo "${FNAME} ${LNAME}" > ${UNAME}.txt
echo "Bye ${LNAME}!"

