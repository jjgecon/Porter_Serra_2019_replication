/*
Replication of the Paper "Gender Differences in the Choice of Mayor"
Code by Javier Gonzalez
Date: 14 Feb 2021
Objective: 
*/

// Load Data set
use "data/PorterSerraAEJ.dta",clear

global interest "female_prof small_class ACumGPA survey_econmajor "
global store_results "female_prof small_class ACumGPA survey_econmajor _cons"

forvalues i = 1/5 {
    local var : word `i' of $store_results
    reg gradePrinciples $interest if female == 0, cluster(class_fe2)
    global lpm1_`var': di %6.3f e(b)[1,`i']
	global lpm1_n = e(N)
	boottest `var', reps(1000) weight(webb) bootcluster(class_fe2) nograph
	global lpm1_p_`var': di %6.3f r(p)
	global lpm1_c1_`var': di %6.3f r(CI)[1,1]
	global lpm1_c2_`var': di %6.3f r(CI)[1,2]
}

// Create table
// Start creating the table
texdoc init "figures_tables\table3_extra.tex", replace force
tex \begin{tabular}{lcc} \toprule 
tex  & Grade in econ  \tabularnewline
tex  & principles \tabularnewline \midrule
tex  &  \tabularnewline
tex Female Professor & ${lpm1_female_prof} \tabularnewline
tex  & (${lpm1_p_female_prof}) &\tabularnewline
tex  & {[}${lpm1_c1_female_prof},${lpm1_c2_female_prof}{]} \tabularnewline
tex  & \tabularnewline
tex Small Class & ${lpm1_small_class} \tabularnewline
tex  & (${lpm1_p_small_class}) \tabularnewline
tex  & {[}${lpm1_c1_small_class},${lpm1_c2_small_class}{]} \tabularnewline
tex  &  \tabularnewline
tex GPA & ${lpm1_ACumGPA} \tabularnewline
tex  & (${lpm1_p_ACumGPA}) \tabularnewline
tex  & {[}${lpm1_c1_ACumGPA},${lpm1_c2_ACumGPA}{]} \tabularnewline
tex  &  \tabularnewline
tex Intended econ major & ${lpm1_survey_econmajor} \tabularnewline
tex  & (${lpm1_p_survey_econmajor}) \tabularnewline
tex  & {[}${lpm1_c1_survey_econmajor},${lpm1_c2_survey_econmajor}{]} \tabularnewline
tex  &  \tabularnewline
tex Constant  & ${lpm1__cons} \tabularnewline
tex  & (${lpm1_p__cons}) \tabularnewline
tex  & {[}${lpm1_c1__cons},${lpm1_c2__cons}{]} \tabularnewline
tex  &  \tabularnewline
tex Observations & ${lpm1_n} \tabularnewline
tex \bottomrule \bottomrule
tex \end{tabular}
texdoc close