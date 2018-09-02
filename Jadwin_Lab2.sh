#!/bin/bash

DIR=$(pwd)

for FILE in $(ls $DIR);
do
    FILESIZE=$(wc -c < $FILE);
    BYTES=$(($BYTES + $FILESIZE));

    READFILE=$(find $FILE -maxdepth 1 -readable | wc -l);
    READ=$(($READ + $READFILE));
    
    WRITEFILE=$(find $FILE -maxdepth 1 -writable | wc -l);
    WRITE=$(($WRITE + $WRITEFILE));

    EXECFILE=$(find $FILE -maxdepth 1 -executable | wc -l);
    EXEC=$(($EXEC + $EXECFILE));
done 

SHSCRIPTS=$(grep -r --include=\*.sh ./ | grep -v grep | wc -l )

printf "\nTotal bytes in '$DIR':$(tput setaf 2) '$BYTES'$(tput sgr0)"
printf "\nTotal readable files: $(tput setaf 2)'$READ'$(tput sgr0)"
printf "\nTotal writable files: $(tput setaf 2)'$WRITE'$(tput sgr0)"
printf "\nTotal executable files: $(tput setaf 2)'$EXEC'$(tput sgr0)"
printf "\nTotal estimated shell scripts: $(tput setaf 2)'$SHSCRIPTS'$(tput sgr0)\n\n"
