/*
Replication of the Paper "Gender Differences in the Choice of Mayor"
Code by Javier Gonzalez
Date: 21 Jan 2021
Objective: Output a LaTeX table similar to Table 4 in the paper
*/

// I mostly recycled the table 3 script

// Set seed to get the same values
set seed 2351414

// Load Data set
use "data/PorterSerraAEJ.dta", clear

// Table 4 //
global interest "treat2016 treatment_class yr_2016"
global store_results "treat2016 treatment_class yr_2016 _cons"
global controls "female_prof instate freshman american ACumGPA gradePrinciples small_class"

// Get the data for the table
forvalues i = 1/4 {
    // LPM 1 no controls number of classes
    local var : word `i' of $store_results
    reg numeconclass $interest if female==1, cluster(class_fe2)
    global lpm1_`var': di %6.3f e(b)[1,`i']
	global lpm1_n = e(N)
	boottest `var', reps(1000) weight(webb) bootcluster(class_fe2) nograph
	global lpm1_p_`var': di %6.3f r(p)
	global lpm1_c1_`var': di %6.3f r(CI)[1,1]
	global lpm1_c2_`var': di %6.3f r(CI)[1,2]
	
	// LPM 2 controls number of classes
    reg numeconclass $interest $controls if female==1, cluster(class_fe2)
    global lpm2_`var': di %6.3f e(b)[1,`i']
	if `i' == 4 {
		global lpm2_`var': di %6.3f e(b)[1,11]
	}
	global lpm2_n = e(N)
	boottest `var', reps(1000) weight(webb) bootcluster(class_fe2) nograph
	global lpm2_p_`var': di %6.3f r(p)
	global lpm2_c1_`var': di %6.3f r(CI)[1,1]
	global lpm2_c2_`var': di %6.3f r(CI)[1,2]
	
	// LPM 3 no controls econ major
    reg econmajor $interest if female==1, cluster(class_fe2)
    global lpm3_`var': di %6.3f e(b)[1,`i']
	global lpm3_n = e(N)
	boottest `var', reps(1000) weight(webb) bootcluster(class_fe2) nograph
	global lpm3_p_`var': di %6.3f r(p)
	global lpm3_c1_`var': di %6.3f r(CI)[1,1]
	global lpm3_c2_`var': di %6.3f r(CI)[1,2]
	
	// LPM 4 controls econ major
    reg econmajor $interest $controls if female==1, cluster(class_fe2)
    global lpm4_`var': di %6.3f e(b)[1,`i']
	if `i' == 4 {
		global lpm4_`var': di %6.3f e(b)[1,11]
	}
	global lpm4_n = e(N)
	boottest `var', reps(1000) weight(webb) bootcluster(class_fe2) nograph
	global lpm4_p_`var': di %6.3f r(p)
	global lpm4_c1_`var': di %6.3f r(CI)[1,1]
	global lpm4_c2_`var': di %6.3f r(CI)[1,2]
}

// Create table
// Start creating the table
texdoc init "figures_tables\table4.tex", replace force
tex \begin{tabular}{lcccc} \toprule 
tex  & Number of econ  & Number of econ & Major in & Major in\tabularnewline
tex  & classes taken  & classes taken  & economics & economics \tabularnewline \midrule
tex  &  &  &  & \tabularnewline
tex Treatment class $\times$ 2016 & ${lpm1_treat2016} & ${lpm2_treat2016} & ${lpm3_treat2016} & ${lpm4_treat2016}\tabularnewline
tex  & (${lpm1_p_treat2016}) & (${lpm2_p_treat2016}) & (${lpm3_p_treat2016}) & (${lpm4_p_treat2016})\tabularnewline
tex  & {[}${lpm1_c1_treat2016},${lpm1_c2_treat2016}{]} & {[}${lpm2_c1_treat2016},${lpm2_c2_treat2016}{]} & {[}${lpm3_c1_treat2016},${lpm3_c2_treat2016}{]} & {[}${lpm4_c1_treat2016},${lpm4_c2_treat2016}{]}\tabularnewline

tex Year 2016  & ${lpm1_yr_2016} & ${lpm2_yr_2016} & ${lpm3_yr_2016} & ${lpm4_yr_2016}\tabularnewline
tex  & (${lpm1_p_yr_2016}) & (${lpm2_p_yr_2016}) & (${lpm3_p_yr_2016}) & (${lpm4_p_yr_2016})\tabularnewline
tex  & {[}${lpm1_c1_yr_2016},${lpm1_c2_yr_2016}{]} & {[}${lpm2_c1_yr_2016},${lpm2_c2_yr_2016}{]} & {[}${lpm3_c1_yr_2016},${lpm3_c2_yr_2016}{]} & {[}${lpm4_c1_yr_2016},${lpm4_c2_yr_2016}{]}\tabularnewline

tex Treatment class (in 2015) & ${lpm1_treatment_class} & ${lpm2_treatment_class} & ${lpm3_treatment_class} & ${lpm4_treatment_class}\tabularnewline
tex  & (${lpm1_p_treatment_class}) & (${lpm2_p_treatment_class}) & (${lpm3_p_treatment_class}) & (${lpm4_p_treatment_class})\tabularnewline
tex  & {[}${lpm1_c1_treatment_class},${lpm1_c2_treatment_class}{]} & {[}${lpm2_c1_treatment_class},${lpm2_c2_treatment_class}{]} & {[}${lpm3_c1_treatment_class},${lpm3_c2_treatment_class}{]} & {[}${lpm4_c1_treatment_class},${lpm4_c2_treatment_class}{]}\tabularnewline

tex Constant  & ${lpm1__cons} & ${lpm2__cons} & ${lpm3__cons} & ${lpm4__cons}\tabularnewline
tex  & (${lpm1_p__cons}) & (${lpm2_p__cons}) & (${lpm3_p__cons}) & (${lpm4_p__cons})\tabularnewline
tex  & {[}${lpm1_c1__cons},${lpm1_c2__cons}{]} & {[}${lpm2_c1__cons},${lpm2_c2__cons}{]} & {[}${lpm3_c1__cons},${lpm3_c2__cons}{]} & {[}${lpm4_c1__cons},${lpm4_c2__cons}{]}\tabularnewline
tex Controls & No & Yes & No & Yes\tabularnewline
tex  &  &  &  & \tabularnewline
tex Observations & ${lpm1_n} & ${lpm2_n} & ${lpm3_n} & ${lpm4_n}\tabularnewline
tex \bottomrule \bottomrule
tex \end{tabular}
texdoc close