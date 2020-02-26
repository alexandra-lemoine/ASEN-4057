#!/bin/bash
#
# Problem 5 for ASEN 4057 Assignment 5
# Author: Connor O'Reilly
# Collabrators: none
# Created: 2/26/2020
# Last Edited: 2/26/2020 
#########################################


#move to directory that contains unorganized .tar.gz file
path_name=/home/coor1752/Assignments/Assignment_5/Materials
cd $path_name


#create new dir for clean file
mkdir MISC_clean

#unzip and move files to dir
tar -xf MISC.tar.gz -C MISC_clean

#move to new dir
cd MISC_clean


#loop: iterate through all files, create folders and store files when needed
for f in ./*
do
    
 #Determine if file has extension
  if [ "${f%.*}" !=  ""  ];then
     
    #determine if dir for extension exists
    if [ -d "${f##*.}" ];then
      mv $f "${f##*.}" 
    else
      mkdir "${f##*.}"
      mv $f "${f##*.}"
    fi

  fi

done

#move back to dir with main dir
cd $path_name

#tar MISC_clean dir
tar -cvf MISC_clean.tar.gz MISC_clean




