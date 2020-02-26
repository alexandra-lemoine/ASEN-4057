#!/bin/bash
#
# Problem 4 for ASEN 4057 Assignment 5 
# Author: Connor O'Reilly
# Collabrators: none
# Created: 2/26/2020
# Last edited: 2/26/2020
# 
# Inputs:
#        $1: file name to calculate average 
# Outputs:
#        none, output to console 
#
#############################################
 
#Updaate directory to be where text files are
cd /home/coor1752/Assignments/Assignment_5/Materials/Grades

file_name=$1

#obtain just grades from txt file
grades=$( cut $file_name -d ';' -f 2 )

#loop: iterate through grades, calulate sum of grades
for g in $grades
do
  let sum+=$g
  let num_tests+=1
done

#calculate avg and output to console
echo "Average for" "${1%.*}" ":"
echo "scale=2; $sum/$num_tests" | bc 
