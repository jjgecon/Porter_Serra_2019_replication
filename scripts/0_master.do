/*
Replication of the Paper "Gender Differences in the Choice of Mayor"
Code by Javier Gonzalez
Date: 03 Feb 2021
Objective: master code to easily replicate the tables and figures of the paper
Gender Differences in the Choice of Major The Importance of Female Role Models

Please note that the data can be found in the articles suplementary resources at
https://www.aeaweb.org/articles?id=10.1257/app.20180426

Stata Version 16
*/

clear all
set varabbrev off 
set more off

// Required Packages:
foreach pkg in "texdoc boottest" {
	capture ssc install `pkg'
}

// Here you can set the directory of the folder
capture cd "D:/OneDrive/Work/Personal Projects/Porter y Serra Replication/replication_exercise"
capture cd "C:\Users\javie\OneDrive\Work\Personal Projects\Porter y Serra Replication\replication_exercise"

** REPLICATION CODE **

do "codes_replication/table1"

do "codes_replication/table2"

// Figure 1
/* need to set the style recording 
In Windows you should copy the files
"porter_serra_bars.grec" and "porter_serra_1.grec"
and paste them in the folder 
C:\Users\YOUR_USER\ado\personal\grec\
*/
do "codes_replication/figure1"

do "codes_replication/table3"

do "codes_replication/table4"

// Figure 2
/* need to set the style recording 
In Windows you should copy the files
"porter_serra_2.grec"
and paste them in the folder 
C:\Users\YOUR_USER\ado\personal\grec\
*/
do "codes_replication/figure2"

// Figure 3
/* need to set the style recording 
In Windows you should copy the files
"porter_serra_3.grec" 
and paste them in the folder 
C:\Users\YOUR_USER\ado\personal\grec\
*/
do "codes_replication/figure3"

// This table in the paper has some wrong labels (typo)
do "codes_replication/table5"

do "codes_replication/table6"

do "codes_replication/table7"

// Figure 4
/* The data set I got did not have the year 2014 :(
*/

do "codes_replication/table8"

do "codes_replication/table9"

// Figure 5
/* need to set the style recording 
In Windows you should copy the files
"porter_serra_4.grec" and "porter_serra_5.grec"
and paste them in the folder 
C:\Users\YOUR_USER\ado\personal\grec\
*/
do "codes_replication/figure5"

** PERFORM EXTRA ANALYSIS **

do "codes_extra_analysis/table1_extra.do"

do "codes_extra_analysis/table2_extra.do"

// Figure 1 extra
/* need to set the style recording 
In Windows you should copy the files
"porter_serra_extra.grec"
and paste them in the folder 
C:\Users\YOUR_USER\ado\personal\grec\

Note: to mathc the font style I needed to export the figure as svg instead of
a pdf
*/
do "codes_extra_analysis/figure1_extra.do"

do "codes_extra_analysis/table3_extra.do"