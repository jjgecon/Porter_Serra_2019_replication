/*
Replication of the Paper "Gender Differences in the Choice of Mayor"
Code by Javier Gonzalez
Date: 21 Jan 2021
Objective: Output a LaTeX table similar to Table 1 in the paper
*/

clear all

// Load Data set
use "data/PorterSerraAEJ.dta"


// re scale some variables to be between 0-100
replace took_year = took_year * 100
replace tookanother = tookanother * 100
replace econmajor = econmajor * 100

// Table 2 //

// Create the variables to loop over
global main_outcomes "took_year tookanother"   
global main_labels `" "Took Intermediate Micro within year" "Took another econ class" "'

// Start creating the table
texdoc init "figures_tables\table2.tex", replace force
tex \begin{tabular}{lcccccc} \toprule \toprule
// split the colum names into 3
tex & Control & Treatment & & Control & Treatment & \\ 
tex & classes 2015 & classes 2015& p-value & classes 2016 & classes 2016 & p-value \\ 
tex & (untreated) & (untreated) & diff. & (untreated) & (treated) & dif\\ 
tex \midrule \\

// first varaibles
forvalues i = 1/2 {
    local a : word `i' of $main_outcomes
	local b : word `i' of $main_labels
	quietly ttest `a' if yr_2016 == 0 & female == 1, by(treatment_class) unequal
	global x2015c: di %6.2f r(mu_1) 
	global x2015t: di %6.2f r(mu_2) 
	global p2015: di %6.2f r(p)
	quietly ttest `a' if yr_2016 == 1 & female == 1, by(treatment_class) unequal
	global x2016c: di %6.2f r(mu_1) 
	global x2016t: di %6.2f r(mu_2) 
	global p2016: di %6.2f r(p)
	tex `b'&${x2015c}&${x2015t}&(${p2015})&${x2016c}&${x2016t}&(${p2016}) \\
	}
// Number of econ classes
quietly ttest numeconclass if yr_2016 == 0 & female == 1, by(treatment_class) unequal
global x2015c: di %6.2f r(mu_1) 
global x2015t: di %6.2f r(mu_2) 
global p2015: di %6.2f r(p)
quietly ttest numeconclass if yr_2016 == 1 & female == 1, by(treatment_class) unequal
global x2016c: di %6.2f r(mu_1)
global x2016t: di %6.2f r(mu_2)
global p2016: di %6.2f r(p)
tex  Number of further econ classes taken &${x2015c}&${x2015t}&(${p2015})&${x2016c}&${x2016t}&(${p2016}) \\
// survey varaibles
quietly ttest econmajor if yr_2016 == 0 & female == 1, by(treatment_class) unequal
global x2015c: di %6.2f r(mu_1) 
global x2015t: di %6.2f r(mu_2) 
global p2015: di %6.2f r(p)
quietly ttest econmajor if yr_2016 == 1 & female == 1, by(treatment_class) unequal
global x2016c: di %6.2f r(mu_1) 
global x2016t: di %6.2f r(mu_2)
global p2016: di %6.2f r(p)
tex  Majored in economics &${x2015c}&${x2015t}&(${p2015})&${x2016c}&${x2016t}&(${p2016}) \\
tex \bottomrule \bottomrule
tex \end{tabular}
texdoc close