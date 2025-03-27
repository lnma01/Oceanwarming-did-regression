clear all
use "D:\Data and code\Data\Panel_data\did_longdata.dta" 
 
notes list

* Robustness tests
cd "D:\Data and code\DID\Robustness tests"

* Parallel trend test

* Generate a policy time variable `policy`, representing the difference between each year and the shock year (2014)
gen policy = year - 2014

* Examine the distribution of the `policy` variable
tab policy

* Restrict the range of the `policy` variable to -3 to 4
replace policy = -3 if policy < -3
replace policy = 4 if policy > 4

* Generate pre-treatment dummies `pre_3`, `pre_2`, `pre_1` for 3, 2, and 1 years before the abnormal ocean warming impact
forvalues i = 3(-1)1 {
    gen pre_`i' = (policy == -`i' & Treat == 1)
}

* Generate a dummy `current` for the year of the abnormal ocean warming impact (2014)
gen current = (policy == 0 & Treat == 1)

* Generate post-treatment dummies `post_1`, `post_2`, `post_3`, `post_4` for 1, 2, 3, and 4 years after the impact
forvalues j = 1(1)4 {
    gen post_`j' = (policy == `j' & Treat == 1)
}

* Drop `pre_1` to avoid multicollinearity (typically, one pre-treatment period is dropped as the reference)
drop pre_1

* Run the regression using `reghdfe`, controlling for year and country fixed effects and set the confidence level to 90%
reghdfe MP Treat Post pre_* current post_* GDP POP PPI, absorb(year country) level(90)


* Plot the coefficients to visualize dynamic treatment effects

* Set the graph font to Arial
graph set window fontface "Arial"

* Set the graph scheme to s1mono (black and white theme)
set scheme s1mono

coefplot, baselevels keep(pre_* current post_*) ///
    vertical ///
    yline(0, lwidth(thin) lcolor(gs8)) ///  // Set Y-axis reference line to gray
    xline(3, lwidth(thin) lpattern(dash) lcolor(gs8)) ///  // Set X-axis reference line to gray
    ylabel(-1.5(0.5)0.5, labsize(8-pt) format(%02.1f)) ///  // Format Y-axis labels to show one decimal place, e.g., 0.5
    xlabel(, labsize(8-pt)) ///
    ytitle("Dynamic effects of ocean warming impact", size(10-pt)) ///
    xtitle("The impact point of abnormal ocean warming", size(10-pt)) ///
    addplot(line @b @at, lcolor(black)) ///
    ciopts(lpattern(dash) recast(rcap) msize(medium) lcolor(black)) ///  // Set confidence intervals to black
    msymbol(circle_hollow) mcolor(black)  // Set points to black
	
* Export the graph as a PNG file to the specified path
graph export "D:\Data and code\DID\Robustness tests\The result of the parallel trend test.png", as(png) name("Graph")
