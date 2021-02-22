/*
Replication of the Paper "Gender Differences in the Choice of Mayor"
Code by Javier Gonzalez
Date: 10 Feb 2021
Objective: 
*/

// Load Data set
use "data/PorterSerraAEJ.dta",clear

global interest "treat2016_fprof fprof_2016 fprof_treat treat2016 female_prof treatment_class yr_2016"
global store_results "treat2016_fprof fprof_2016 fprof_treat treat2016 female_prof treatment_class yr_2016 _cons"
global controls "instate freshman american ACumGPA small_class gradePrinciples"

gen treat2016_fprof = treat2016 * female_prof
gen fprof_2016 = female_prof*yr_2016
gen fprof_treat = treatment_class*female_prof

forvalues i = 1/8 {
    local var : word `i' of $store_results
    reg took_fall $interest $controls if female == 1, cluster(class_fe2)
    global lpm1_`var': di %6.3f e(b)[1,`i']
	if `i' == 8 {
		global lpm4_`var': di %6.3f e(b)[1,14]
	}
	global lpm1_n = e(N)
	boottest `var', reps(1000) weight(webb) bootcluster(class_fe2) nograph
	global lpm1_p_`var': di %6.3f r(p)
	global lpm1_c1_`var': di %6.3f r(CI)[1,1]
	global lpm1_c2_`var': di %6.3f r(CI)[1,2]
	
    reg econmajor $interest $controls if female == 1, cluster(class_fe2)
    global lpm2_`var': di %6.3f e(b)[1,`i']
	if `i' == 8 {
		global lpm2_`var': di %6.3f e(b)[1,14]
	}
	global lpm2_n = e(N)
	boottest `var', reps(1000) weight(webb) bootcluster(class_fe2) nograph
	global lpm2_p_`var': di %6.3f r(p)
	global lpm2_c1_`var': di %6.3f r(CI)[1,1]
	global lpm2_c2_`var': di %6.3f r(CI)[1,2]
	
    reg numeconclass $interest $controls if female == 1, cluster(class_fe2)
    global lpm3_`var': di %6.3f e(b)[1,`i']
	if `i' == 8 {
		global lpm4_`var': di %6.3f e(b)[1,14]
	}
	global lpm3_n = e(N)
	boottest `var', reps(1000) weight(webb) bootcluster(class_fe2) nograph
	global lpm3_p_`var': di %6.3f r(p)
	global lpm3_c1_`var': di %6.3f r(CI)[1,1]
	global lpm3_c2_`var': di %6.3f r(CI)[1,2]
	
    reg tookanother $interest $controls if female == 1, cluster(class_fe2)
    global lpm4_`var': di %6.3f e(b)[1,`i']
	if `i' == 8 {
		global lpm4_`var': di %6.3f e(b)[1,14]
	}
	global lpm4_n = e(N)
	boottest `var', reps(1000) weight(webb) bootcluster(class_fe2) nograph
	global lpm4_p_`var': di %6.3f r(p)
	global lpm4_c1_`var': di %6.3f r(CI)[1,1]
	global lpm4_c2_`var': di %6.3f r(CI)[1,2]
}

// Create table
// Start creating the table
texdoc init "figures_tables\table1_extra.tex", replace force
tex \begin{tabular}{lcccc} \toprule 
tex  & Took class  & Major in & Number of  & Took another\tabularnewline
tex  & next Fall  & economics  & econ classes & econ class \tabularnewline \midrule
tex  &  &  &  & \tabularnewline
tex Female Profesor $\times$ Year 2016 & ${lpm1_treat2016_fprof} & ${lpm2_treat2016_fprof} & ${lpm3_treat2016_fprof} & ${lpm4_treat2016_fprof}\tabularnewline
tex $\times$ Treated class  & (${lpm1_p_treat2016_fprof}) & (${lpm2_p_treat2016_fprof}) & (${lpm3_p_treat2016_fprof}) & (${lpm4_p_treat2016_fprof})\tabularnewline
tex  & {[}${lpm1_c1_treat2016_fprof},${lpm1_c2_treat2016_fprof}{]} & {[}${lpm2_c1_treat2016_fprof},${lpm2_c2_treat2016_fprof}{]} & {[}${lpm3_c1_treat2016_fprof},${lpm3_c2_treat2016_fprof}{]} & {[}${lpm4_c1_treat2016_fprof},${lpm4_c2_treat2016_fprof}{]}\tabularnewline
tex  &  &  &  & \tabularnewline
tex Female Profesor $\times$  & ${lpm1_fprof_2016} & ${lpm2_fprof_2016} & ${lpm3_fprof_2016} & ${lpm4_fprof_2016}\tabularnewline
tex Year 2016  & (${lpm1_p_fprof_2016}) & (${lpm2_p_fprof_2016}) & (${lpm3_p_fprof_2016}) & (${lpm4_p_fprof_2016})\tabularnewline
tex  & {[}${lpm1_c1_fprof_2016},${lpm1_c2_fprof_2016}{]} & {[}${lpm2_c1_fprof_2016},${lpm2_c2_fprof_2016}{]} & {[}${lpm3_c1_fprof_2016},${lpm3_c2_fprof_2016}{]} & {[}${lpm4_c1_fprof_2016},${lpm4_c2_fprof_2016}{]}\tabularnewline
tex  &  &  &  & \tabularnewline
tex Female Profesor $\times$ & ${lpm1_fprof_treat} & ${lpm2_fprof_treat} & ${lpm3_fprof_treat} & ${lpm4_fprof_treat}\tabularnewline
tex Treated class & (${lpm1_p_fprof_treat}) & (${lpm2_p_fprof_treat}) & (${lpm3_p_fprof_treat}) & (${lpm4_p_fprof_treat})\tabularnewline
tex  & {[}${lpm1_c1_fprof_treat},${lpm1_c2_fprof_treat}{]} & {[}${lpm2_c1_fprof_treat},${lpm2_c2_fprof_treat}{]} & {[}${lpm3_c1_fprof_treat},${lpm3_c2_fprof_treat}{]} & {[}${lpm4_c1_fprof_treat},${lpm4_c2_fprof_treat}{]}\tabularnewline
tex  &  &  &  & \tabularnewline
tex Treated class $\times$ & ${lpm1_treat2016} & ${lpm2_treat2016} & ${lpm3_treat2016} & ${lpm4_treat2016}\tabularnewline
tex Year 2016 & (${lpm1_p_treat2016}) & (${lpm2_p_treat2016}) & (${lpm3_p_treat2016}) & (${lpm4_p_treat2016})\tabularnewline
tex & {[}${lpm1_c1_treat2016},${lpm1_c2_treat2016}{]} & {[}${lpm2_c1_treat2016},${lpm2_c2_treat2016}{]} & {[}${lpm3_c1_treat2016},${lpm3_c2_treat2016}{]} & {[}${lpm4_c1_treat2016},${lpm4_c2_treat2016}{]}\tabularnewline
tex  &  &  &  & \tabularnewline
tex Female Profesor & ${lpm1_female_prof} & ${lpm2_female_prof} & ${lpm3_female_prof} & ${lpm4_female_prof}\tabularnewline
tex & (${lpm1_p_female_prof}) & (${lpm2_p_female_prof}) & (${lpm3_p_female_prof}) & (${lpm4_p_female_prof})\tabularnewline
tex & {[}${lpm1_c1_female_prof},${lpm1_c2_female_prof}{]} & {[}${lpm2_c1_female_prof},${lpm2_c2_female_prof}{]} & {[}${lpm3_c1_female_prof},${lpm3_c2_female_prof}{]} & {[}${lpm4_c1_female_prof},${lpm4_c2_female_prof}{]}\tabularnewline
tex  &  &  &  & \tabularnewline
tex Year 2016 & ${lpm1_yr_2016} & ${lpm2_yr_2016} & ${lpm3_yr_2016} & ${lpm4_yr_2016}\tabularnewline
tex  & (${lpm1_p_yr_2016}) & (${lpm2_p_yr_2016}) & (${lpm3_p_yr_2016}) & (${lpm4_p_yr_2016})\tabularnewline
tex  & {[}${lpm1_c1_yr_2016},${lpm1_c2_yr_2016}{]} & {[}${lpm2_c1_yr_2016},${lpm2_c2_yr_2016}{]} & {[}${lpm3_c1_yr_2016},${lpm3_c2_yr_2016}{]} & {[}${lpm4_c1_yr_2016},${lpm4_c2_yr_2016}{]}\tabularnewline
tex  &  &  &  & \tabularnewline
tex Treated class & ${lpm1_treatment_class} & ${lpm2_treatment_class} & ${lpm3_treatment_class} & ${lpm4_treatment_class}\tabularnewline
tex  & (${lpm1_p_treatment_class}) & (${lpm2_p_treatment_class}) & (${lpm3_p_treatment_class}) & (${lpm4_p_treatment_class})\tabularnewline
tex  & {[}${lpm1_c1_treatment_class},${lpm1_c2_treatment_class}{]} & {[}${lpm2_c1_treatment_class},${lpm2_c2_treatment_class}{]} & {[}${lpm3_c1_treatment_class},${lpm3_c2_treatment_class}{]} & {[}${lpm4_c1_treatment_class},${lpm4_c2_treatment_class}{]}\tabularnewline
tex  &  &  &  & \tabularnewline
tex Constant  & ${lpm1__cons} & ${lpm2__cons} & ${lpm3__cons} & ${lpm4__cons}\tabularnewline
tex  & (${lpm1_p__cons}) & (${lpm2_p__cons}) & (${lpm3_p__cons}) & (${lpm4_p__cons})\tabularnewline
tex  & {[}${lpm1_c1__cons},${lpm1_c2__cons}{]} & {[}${lpm2_c1__cons},${lpm2_c2__cons}{]} & {[}${lpm3_c1__cons},${lpm3_c2__cons}{]} & {[}${lpm4_c1__cons},${lpm4_c2__cons}{]}\tabularnewline
tex  &  &  &  & \tabularnewline
tex Controls & Yes & Yes & Yes & Yes \tabularnewline
tex Observations & ${lpm1_n} & ${lpm2_n} & ${lpm3_n} & ${lpm4_n}\tabularnewline
tex \bottomrule \bottomrule
tex \end{tabular}
texdoc close