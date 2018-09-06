#!/bin/bash

# Get directory
DIR=$(pwd)

# Loop through files in directory
for FILE in $(ls $DIR);
do 
    # Get size of file	
    FILESIZE=$(wc -c < $FILE);
    # Add up total size of dir
    BYTES=$(($BYTES + $FILESIZE));
    
    # Determine if file is readable
    READFILE=$(find $FILE -maxdepth 1 -readable | wc -l);
    READ=$(($READ + $READFILE));
    
    # Determine if file is writeable
    WRITEFILE=$(find $FILE -maxdepth 1 -writable | wc -l);
    WRITE=$(($WRITE + $WRITEFILE));
    
    # Determine if file is executable
    EXECFILE=$(find $FILE -maxdepth 1 -executable | wc -l);
    EXEC=$(($EXEC + $EXECFILE));
done 

KB=$(echo "scale=0; $BYTES*0.001" | bc -l )
KB=$(echo "${KB%.*}")

# Determine how many shell scripts are in directory
SHSCRIPTS=$(grep -r --include=\*.sh ./ | grep -v grep | wc -l )

printf "\nTotal bytes in '$DIR':$(tput setaf 2) '$BYTES' BYTES (~$KB KB)$(tput sgr0)"
printf "\nTotal readable files: $(tput setaf 2)'$READ'$(tput sgr0)"
printf "\nTotal writable files: $(tput setaf 2)'$WRITE'$(tput sgr0)"
printf "\nTotal executable files: $(tput setaf 2)'$EXEC'$(tput sgr0)"
printf "\nTotal estimated shell scripts: $(tput setaf 2)'$SHSCRIPTS'$(tput sgr0)\n\n"
