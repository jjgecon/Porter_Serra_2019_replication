/*
Replication of the Paper "Gender Differences in the Choice of Mayor"
Code by Javier Gonzalez
Date: 21 Jan 2021
Objective: master code to easily replicate the tables and figures of the paper
Gender Differences in the Choice of Major The Importance of Female Role Models

Please note that the data can be found in the articles suplementary resources at
https://www.aeaweb.org/articles?id=10.1257/app.20180426
*/

clear all
set more off

// Here you can set the directory of the folder with the data
capture cd "insert_folder_directory"

// Table 1
do "codes/table1"

// Table 2
do "codes/table2"

// Figure 1
/* need to set the style recording 
In Windows you should copy the files
"porter_serra_bars.grec" and "porter_serra_1.grec"
and paste them in the folder 
C:\Users\YOUR_USER\ado\personal\grec\
*/
do "codes/figure1"

// Table 3
do "codes/table3"

// Table 4
do "codes/table4"

// Figure 2
/* need to set the style recording 
In Windows you should copy the files
"porter_serra_2.grec"
and paste them in the folder 
C:\Users\YOUR_USER\ado\personal\grec\
*/
do "codes/figure2"

// Figure 3
/* need to set the style recording 
In Windows you should copy the files
"porter_serra_3.grec" 
and paste them in the folder 
C:\Users\YOUR_USER\ado\personal\grec\
*/
do "codes/figure3"

// Table 5
// This table in the paper has some wrong labels (typo)
do "codes/table5"

// Table 6
do "codes/table6"

// Table 7
do "codes/table7"

// Figure 4
/* The data set I got did not have the year 2014 :(
*/

// Table 8
do "codes/table8"

// Table 9
do "codes/table9"

// Figure 5
/* need to set the style recording 
In Windows you should copy the files
"porter_serra_4.grec" and "porter_serra_5.grec"
and paste them in the folder 
C:\Users\YOUR_USER\ado\personal\grec\
*/
do "codes/figure5"