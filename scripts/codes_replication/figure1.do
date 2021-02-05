/*
Replication of the Paper "Gender Differences in the Choice of Mayor"
Code by Javier Gonzalez
Date: 21 Jan 2021
Objective: Output the Figure 1 in the paper with similar style
*/

clear all

// Load Data set
use "data/PorterSerraAEJ.dta"


// re scale some variables to be between 0-100
replace took_year = took_year * 100
replace tookanother = tookanother * 100
replace econmajor = econmajor * 100

// recode the group for the bar charts
gen g1 = 1 if yr_2016 == 0 & treatment_class == 0
replace g1 = 2 if yr_2016 == 0 & treatment_class == 1
replace g1 = 3 if yr_2016 == 1 & treatment_class == 0
replace g1 = 4 if yr_2016 == 1 & treatment_class == 1

// Figure 1 //
/* need to set the style recording that is the command play(porter_serra_bars) 
and play(porter_serra_1)

To use this command in Windows you should copy the files
"porter_serra_bars.grec" and "porter_serra_1.grec"
and paste them in the folder C:\Users\YOUR_USER\ado\personal\grec\
*/

global interest_vars "took_year tookanother"
global panel "A B"

forvalues i = 1/2 {
    local a : word `i' of $interest_vars
	local b : word `i' of $panel
	graph bar (mean) `a' if female == 1, over(g1) asyvars ///
	play(porter_serra_bars) ytitle("Percentage") title("Panel `b'") 
	graph save "Graph" "figures_tables\aux_panels\Panel `b'.gph", replace
}

graph bar (mean) numeconclass if female == 1, over(g1) asyvars ///
play(porter_serra_1) ytitle("Percentage") title("Panel C")
graph save "Graph" "figures_tables\aux_panels\Panel C.gph", replace

graph bar (mean) econmajor if female == 1, over(g1) asyvars ///
play(porter_serra_bars) ytitle("Percentage") title("Panel D")
graph save "Graph" "figures_tables\aux_panels\Panel D.gph", replace

// Now we get the combination of all panels
graph combine "figures_tables\aux_panels\Panel A.gph" ///
"figures_tables\aux_panels\Panel B.gph" ///
"figures_tables\aux_panels\Panel C.gph" ///
"figures_tables\aux_panels\Panel D.gph", graphregion(fcolor(white)) xsize(9) ysize(7)

graph export "figures_tables\figure1.pdf", as(pdf) name("Graph") replace