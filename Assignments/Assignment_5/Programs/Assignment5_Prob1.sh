#!/bin/bash
#
# Problem 1 for ASEN 4057 Assignment 5
# Author: Connor T. O'Reilly
# Collabrators: none
# Created: 2/26/2020 
# Last Edited: 2/26/2020
#
# Inputs: a and b are integer inputs 
#         assuming a is smaller than b 
# Outputs: Display to console 
#
########################################

#get user inputs assuming a < b
echo
echo Input a:;read a
echo Input b:; read b
echo 


echo "Output: "
#loop: output numbers from a to b 
for((i=a;i<=b;i=$[i+1]))
do
  echo $i
done

echo
