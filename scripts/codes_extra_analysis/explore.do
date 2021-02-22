/*
Replication of the Paper "Gender Differences in the Choice of Mayor"
Code by Javier Gonzalez
Date: 21 Jan 2021
Objective: Explore what male students could've been influenced 
by the intervention
*/

clear all

// Load Data set
use "data/PorterSerraAEJ.dta"

// for some reason having a female_prof had some influence in whether students take
// the econ course next fall (so a teacher role model?)
reg took_fall treat2016 treatment_class yr_2016 female_prof, r

// test means
reg took_fall female_prof if female == 0, r
reg took_fall female_prof if female == 1, r

// try to visualize
label define female 0 "male" 1 "female", modify
label define female_prof 0 "male prof" 1 "female prof", modify
label values female female
label values female_prof female_prof

reg took_fall female_prof##female gradePrinciples ACumGPA top yr_2016, r

// get a better interpretation
probit took_fall female_prof##female gradePrinciples ACumGPA top yr_2016
margins female_prof, atmeans post

// get the values to use in the bar graph
gen prob_fprof = _b[1.female_prof] if female_prof == 1
replace prob_fprof = _b[0.female_prof] if female_prof == 0

// get the confidence intervals
gen fprof_min = r(table)[5,1] if female_prof == 0
replace fprof_min = r(table)[5,2] if female_prof == 1
gen fprof_max = r(table)[6,1] if female_prof == 0
replace fprof_max = r(table)[6,2] if female_prof == 1

// bar graph to visualize the different probabilities.
collapse (mean) prob_fprof fprof_min fprof_max, by(female_prof)
graph twoway (bar prob_fprof female_prof if female_prof==0) ///
			 (bar prob_fprof female_prof if female_prof==1) ///
			 (rcap fprof_min fprof_max female_prof)
			 
// pretty much driven by the female students.
probit took_fall female_prof##female gradePrinciples ACumGPA top yr_2016
margins female_prof, at(female == 1) 
margins female_prof, at(female == 0) 

//////////////////////////////////////////////////////////////////
gen treat2016_fprof = treat2016 * female_prof
gen fprof_2016 = female_prof*yr_2016
gen fprof_treat = treatment_class*female_prof
global interest "treat2016_fprof fprof_2016 fprof_treat treat2016 female_prof treatment_class yr_2016"
global controls "instate freshman american ACumGPA small_class gradePrinciples"

foreach y of varlist took_fall econmajor numeconclass tookanother {
	reg `y' $interest $controls if female == 0, cluster(class_fe2)
}

foreach y of varlist took_fall econmajor numeconclass tookanother {
	probit `y' $interest $controls if female == 1, cluster(class_fe2)
}