#!/bin/bash
#
# Problem 3 for ASEN 4057 Assignment 5
# Author: Connor T. O'Reilly
# Collabrators: none
# Created: 2/26/2020
# Last Edited: 2/26/2020
#
# Purpose:
#        Rename multiple files with a basename and number, for a specific extension
# Inputs:
#        $1: basename to rename files
#        $2: extension of files to be renamed 
############################################## 

#specify path to file containing provided .tar.gz file
path_dir=/home/coor1752/Assignments/Assignment_5/Materials/Pictures

cd $path_dir

basename=$1
extension=$2

i=0

#loop: iterate through all files with specified extension and rename
for f in *.$extension 
do
  #create new filename
  file_name=$( printf "%s%03d%s%s" $basename $i "." $extension)
  
  #rename and iterate 
  mv "$f" "$file_name" 
  let i+=1
done
