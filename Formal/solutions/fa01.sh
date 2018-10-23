#!/bin/bash
echo "Hello User!"
echo "Give me your name"
read NAME
echo "${NAME}, please give me your username"
read USERNAME
echo "${NAME}, please give me a file extention"
read FEXT
for i in 1 2 3 4 5
do
  echo "I am the ${FEXT} file number ${i}" > "${USERNAME}${i}.${FEXT}"
done
mkdir ${FEXT}_files
cp ./*.${FEXT} ./${FEXT}_files/
tar -cvf ${USERNAME}_${FEXT}.tar ./${FEXT}_files/
tar -tf ${USERNAME}_${FEXT}.tar > tartoc.txt
echo "Bye ${NAME}!" 
