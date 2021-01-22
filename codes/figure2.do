/*
Replication of the Paper "Gender Differences in the Choice of Mayor"
Code by Javier Gonzalez
Date: 21 Jan 2021
Objective: Output the Figure 2 in the paper with similar style
*/

clear all

// Load Data set
use "data/PorterSerraAEJ.dta"


// re scale some variables to be between 0-100
replace Major_STEM = Major_STEM * 100
replace Major_Finance = Major_Finance * 100
replace Major_Business = Major_Business * 100
replace Major_Marketing = Major_Marketing * 100

// recode the group for the bar charts
gen g1 = 1 if yr_2016 == 0 & treatment_class == 0
replace g1 = 2 if yr_2016 == 0 & treatment_class == 1
replace g1 = 3 if yr_2016 == 1 & treatment_class == 0
replace g1 = 4 if yr_2016 == 1 & treatment_class == 1

graph bar (mean) Major_Business if female == 1, over(g1) asyvars

// Figure 2 //
/* 
In Windows you should copy the files
"porter_serra_2.grec"
and paste them in the folder C:\Users\YOUR_USER\ado\personal\grec\
*/

global interest_vars "Major_STEM Major_Finance Major_Business Major_Marketing"
global panel "A B C D"

forvalues i = 1/4 {
    local a : word `i' of $interest_vars
	local b : word `i' of $panel
	graph bar (mean) `a' if female == 1, over(g1) asyvars ///
	play(porter_serra_2) ytitle("Percentage") title("Panel `b'") 
	graph save "Graph" "figures_tables\aux_panels\Panel `b'.gph", replace
}

// Now we get the combination of all panels
graph combine "figures_tables\aux_panels\Panel A.gph" ///
"figures_tables\aux_panels\Panel B.gph" ///
"figures_tables\aux_panels\Panel C.gph" ///
"figures_tables\aux_panels\Panel D.gph", graphregion(fcolor(white)) xsize(9) ysize(7)

graph export "figures_tables\figure2.pdf", as(pdf) name("Graph") replace