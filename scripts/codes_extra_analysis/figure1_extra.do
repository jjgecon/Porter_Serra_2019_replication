/*
Replication of the Paper "Gender Differences in the Choice of Mayor"
Code by Javier Gonzalez
Date: 14 Feb 2021
Objective: create a figure to explain the difference in probability of econ_mayor
for male students in treated classes with a female instructor
*/

use "data/PorterSerraAEJ.dta",clear


global interest "fprof_2016 fprof_treat treat2016 female_prof treatment_class yr_2016"
global controls "instate freshman american ACumGPA small_class gradePrinciples"

gen treat2016_fprof = treat2016 * female_prof
gen fprof_2016 = female_prof*yr_2016
gen fprof_treat = treatment_class*female_prof

probit econmajor i.treat2016_fprof $interest $controls if female == 0, cluster(class_fe2)
margins treat2016_fprof, atmeans post

// get the values to use in the bar graph
gen prob_fprof = _b[1.treat2016_fprof] if female_prof == 1
replace prob_fprof = _b[0.treat2016_fprof] if female_prof == 0

// get the confidence intervals
gen fprof_min = r(table)[5,1] if female_prof == 0
replace fprof_min = r(table)[5,2] if female_prof == 1
gen fprof_max = r(table)[6,1] if female_prof == 0
replace fprof_max = r(table)[6,2] if female_prof == 1

// bar graph to visualize the different probabilities.
collapse (mean) prob_fprof fprof_min fprof_max, by(female_prof)

graph set window fontface "Palatino"
graph twoway (bar prob_fprof female_prof if female_prof==0) ///
			 (bar prob_fprof female_prof if female_prof==1) ///
			 (rcap fprof_min fprof_max female_prof), ///
			 play(porter_serra_extra)
			 
graph export "figures_tables\figure1_extra.svg", as(svg) name("Graph") fontface("Palatino")  replace