#!/bin/bash
#
# Problem 2 for ASEN 4057 Assignment 5
#
# Author: Connor T. O'Reilly
# Collabrators: none
# Created: 2/26/2020
# Last Edited: 2/26/2020
# 
# Inputs: 
#         $1: file or directory to be examined
# 
# Outputs: 
#         Display to console
#
##################################################

echo
#determine if file exists
if [ -e $1 ]; then 
  var1="File exists"
  
  #determine if dir
  if [ -d $1 ]; then
    var1="$var1 and is also a directory"
  fi

  #determine if reg
  if [ -f $1 ]; then 
    var1="$var1 and is also a regular file" 
  fi 
  
  #determine if other
  if [ ! -f $1 ] && [ ! -d $1 ]; then 
    var1="$var1 and is other"
  fi
  echo $var1

  #obtain user permissions
  echo
  file_per=$(ls -l $1 | head -c 10 | cut -c 2-4)
  echo "User Permissions: "
  if [[ $file_per = *r* ]]; then echo "User has read Permission" ; fi
  if [[ $file_per = *w* ]]; then echo "User has write Permission" ; fi
  if [[ $file_per = *x* ]]; then echo "User has execute Permission" ; fi

#display if file DNE
else 
 echo "File DNE"
fi

echo 
